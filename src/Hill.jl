"""
This file fits Hill function to the parameters
"""

""" This functions takes in hill parameters for all the concentrations and calculates
DDE parameters, passes them to residual function and based off of these, optimizes the model
and estimates hill parameters. """
function residHill(x::Vector, conc::Vector, g1::Matrix, g2::Matrix)
    res = 0.0
    params = getODEparams(x, conc)
    t = LinRange(0.0, 0.5 * size(g1, 1), size(g1, 1))
    g0 = g1[1, :] + g2[1, :]

    # Solve each concentration separately
    for ii = 1:length(conc)
        res += predict(params[:, ii], g0[ii], t, g1[:, ii], g2[:, ii])[1]
    end

    return res
end


""" Generic setup for optimization. """
function optimize_helper(f, low::Vector, high::Vector, maxstep::Int)
    results_ode = bboptimize(
        f;
        SearchRange = collect(zip(low, high)),
        NumDimensions = length(low),
        TraceMode = :verbose,
        TraceInterval = 100,
        MaxSteps = maxstep,
    )

    return best_fitness(results_ode), best_candidate(results_ode)
end


""" Hill optimization function. """
function optimize_hill(conc::Vector, g1::Matrix, g2::Matrix; maxstep = 100000)
    f(x) = residHill(x, conc, g1, g2)

    # [EC50, k, min_a1, max_a1, min_a2, max_a2, min_b1, max_b1, min_b2, max_b2, max_g11, max_g12, max_g21, max_g22, min%G1]
    low = [minimum(conc), 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 1e-9, 0.25]
    high = [2*maximum(conc), 10.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 0.75]

    return optimize_helper(f, low, high, maxstep)
end

""" A function to convert the estimated hill parameters back to ODE parameters. """
function getODEparams(p::Vector, concentrations::Vector{Float64})
    effects = Matrix{eltype(p)}(undef, 9, length(concentrations))

    # Scaled drug effect
    xx = 1.0 ./ (1.0 .+ (p[1] ./ (concentrations .+ eps())) .^ p[2])

    # [EC50, left, right, steepness]
    effects[1, :] = p[3] .+ (p[4] - p[3]) .* xx
    effects[2, :] = p[5] .+ (p[6] - p[5]) .* xx
    effects[3, :] = p[7] .+ (p[8] - p[7]) .* xx
    effects[4, :] = p[9] .+ (p[10] - p[9]) .* xx
    effects[5, :] = p[11] .* xx
    effects[6, :] = p[12] .* xx
    effects[7, :] = p[13] .* xx
    effects[8, :] = p[14] .* xx
    effects[9, :] .= p[15]

    return effects
end
