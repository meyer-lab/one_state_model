""" To find the sensitivity of the model to a parameter. """
function sensitivity(params::Vector, paramRange::Vector, conc::Vector, i::Int, g1::Matrix, g2::Matrix)
    result = zeros(length(paramRange))
    for j = 1:length(paramRange)
        temp = copy(params)
        temp[i] = paramRange[j]
        result[j] = residHill(temp, conc, g1, g2)
    end
    return result
end

""" Calculate the sensitivity to all parameters. """
function allSensitivity(params::Vector, conc_l::Vector, g1::Matrix, g2::Matrix)
    @assert length(params) == 13
    b = copy(params)

    convRange = 10 .^ range(-1, stop = 1, length = 101)
    results = zeros(length(convRange), length(params))
    paramRanges = zeros(length(convRange), length(params))

    for k = 1:length(params)
        paramRanges[:, k] = b[k] .* convRange
        results[:, k] = sensitivity(b, paramRanges[:, k], conc_l, k, g1, g2)
    end
    return results, paramRanges
end

""" Plots the sensitivity for a parameter with a vertical line of the real value of the parameter."""
function plotUnitSensitivity(paramRange, result, realParam, i)
    label = [
        "EC50",
        "min alpha",
        "max alpha",
        "steepnsess",
        "min beta",
        "max beta",
        "max gamma G1",
        "max gamma G2",
        "% in G1",
        "# of G1 species",
        "# of G2 species",
    ]
    plot(
        paramRange,
        result,
        legend = :false,
        xlabel = string("[log] ", label[i], " range"),
        ylabel = "[log] cost",
        yscale = :log10,
        xscale = :log10,
        xaxis = :log10,
        yaxis = :log10,
    )
    plot!([realParam], seriestype = "vline", margin = 0.3cm, legend = :false)
    ylims!((1E2, 1E5))
end

""" This function calculates the simulated cell number for a pair of drugs in their exact concentration.  """
function calc_cellNum(pDr1, pDr2, g0)
    tt = 0.0:1.0:96.0
    g1d1, g2d1, _ = predict(pDr1, g0, tt)
    g1d2, g2d2, _ = predict(pDr2, g0, tt)
    normNum = 1.0 .- [(g1d1[end] + g2d1[end]) / g0, (g1d2[end] + g2d2[end]) / g0]
    combin = -((normNum[1] + normNum[2] - normNum[1] * normNum[2]) .- 1.0) * g0
    return combin
end

""" Calculates the difference between the bliss_cell number and bliss_params. """
function calc_diff(Dr1_params, Dr2_params, effs, Dr1Ind, Dr2Ind, conc1_indx, conc2_indx, g0)
    # Dr1_params/Dr2_params is a 9 x 1 Array, including the 9 parameters of ODE model. 
    combin = calc_cellNum(Dr1_params, Dr2_params, g0)
    bliss_comb = DrugResponseModel.fullCombinationParam(effs[:, :, Dr1Ind], effs[:, :, Dr2Ind], effs, 8)
    bliss_comb_cellnum = BlissModelComb(bliss_comb, g0)[conc1_indx, conc2_indx]
    return combin - bliss_comb_cellnum
end

function get_derivative(x, Dr2_params, effs, Dr1Ind, Dr2Ind, conc1_indx, conc2_indx, g0)
    fd(x) = calc_diff(x, Dr2_params, effs, Dr1Ind, Dr2Ind, conc1_indx, conc2_indx, g0) # is this closure?
    return ForwardDiff.gradient(fd, x)
end
