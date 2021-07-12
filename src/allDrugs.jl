""" In this file we fit all the drugs att once. """
function residHillAll(hP, concentrations::Matrix, g1::Array, g2::Array)
    res = 0.0

    # Solve for all drugs
    t = 1
    for j = 1:5
        hill = hP[[t:(t + 17); 91:98]]
        res += residHill(hill, concentrations[:, j], g1[:, :, j], g2[:, :, j])
        t += 18
    end
    return res
end

""" Organize Hill parameters for each drug in a 2D array. """
function Hill_p_eachDr(p)
    HillP = Matrix{eltype(p)}(undef, 14, 5)
    # each column: [EC50, steepness, max_g1,1_prog., max_g1,2_prog., max_g2,1_prog., max_g2,2_prog., max_g11_death, max_g12_death, max_g21_death, max_g22_death]
    j = 1
    for i = 1:5
        HillP[:, i] .= p[j:(j + 17)]
        j += 18
    end
    HillP
end


function optim_all(concs::Array{Float64, 2}, g1::Array{Float64, 3}, g2::Array{Float64, 3}; maxiter = 800000)
    f(x) = residHillAll(x, concs, g1, g2)

    lP = [minimum(concs); 0.01; 5e-9 * ones(16)]
    low = vcat(lP, lP, lP, lP, lP, 5e-9, 5e-9, 5e-9, 5e-9, 5e-9, 5e-9, 5e-9, 5e-9)
    hP = [maximum(concs); 10.0; 1.0 * ones(16)]
    high = vcat(hP, hP, hP, hP, hP, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)

    return optimize_helper(f, low, high, maxiter)
end

""" Takes in the Hill params and the index corresponding to the drug of interest, outputs the 9 long params at EC50. """
function EC50_params(p, i)
    d = Hill_p_eachDr(p)
    # returns the following at EC50: [g1_prog., g2_prog, g1_death, g2_death, g1%]
    return append!([
        p[71] + (d[3, i] - p[71]) / 2,
        p[72] + (d[4, i] - p[72]) / 2,
        p[73] + (d[5, i] - p[73]) / 2,
        p[74] + (d[6, i] - p[74]) / 2,
        p[75] + (d[7, i] - p[75]) / 2,
        p[76] + (d[8, i] - p[76]) / 2,
        d[9, i] / 2,
        d[10, i] / 2,
        d[11, i] / 2,
        d[12, i] / 2,
        d[13, i] / 2,
        d[14, i] / 2,
    ])
end

function parameters()
    # return ps = [34.6303, 1.35959, 0.360926, 0.020735, 2.14239e-6, 0.00873742, 0.291827, 6.23808e-6, 0.263093, 1.86469, 0.0638457, 5.26201e-7, 0.0357197, 3.38634e-7, 1.71977e-5, 4.20002e-7, 0.00385455, 2.82233e-5, 19.8599, 1.48917, 1.99969, 0.179443, 7.98855e-7, 0.00299272, 1.75263, 1.99766, 0.114934, 1.87553, 3.65302e-5, 1.13364e-7, 0.0543858, 7.83016e-7, 0.222225, 0.0277672, 6.12458e-7, 0.144828, 5.17319, 1.8511, 2.0, 0.324095, 0.503695, 0.293661, 0.416597, 0.220342, 0.261569, 1.88773, 3.2247e-6, 1.82269e-7, 1.2028e-6, 1.09096e-7, 8.27941e-8, 0.0768722, 2.0273e-7, 2.94502e-6, 2.55094, 2.78168, 0.986578, 0.0695119, 0.353046, 0.0467065, 0.220959, 1.99977, 0.318245, 0.0387224, 1.01961e-5, 1.36537e-7, 2.60407e-6, 1.63094e-7, 0.136062, 6.90303e-6, 1.4639e-7, 0.0362207, 35.9225, 1.10826, 1.99851, 0.0419418, 0.769692, 0.26942, 1.43254, 1.54905, 0.299407, 1.86994, 2.81656e-5, 5.32358e-7, 1.687e-6, 1.45854e-6, 2.97086e-5, 0.0353744, 0.0254184, 2.32567e-5, 1.99713, 0.10733, 1.99997, 0.988148, 1.74038, 1.99998, 0.20115, 1.84866]
    return ps = [35.5847, 1.1752, 0.969265, 0.0114057, 0.351768, 0.0119378, 0.10207, 0.967315, 0.561704, 0.385224, 0.000104358, 0.0206385, 1.32302e-6, 1.67216e-6, 0.0211362, 1.89931e-5, 2.11461e-6, 6.2353e-6, 14.635, 1.51735, 0.973835, 0.986118, 0.00125898, 0.175732, 0.381882, 0.450545, 0.714431, 0.554287, 8.73875e-6, 1.28229e-5, 0.0248706, 4.95874e-7, 4.59917e-7, 7.39547e-6, 0.10873, 0.0299143, 4.50343, 1.83346, 0.999816, 0.999407, 7.97175e-7, 0.271109, 0.162148, 0.332318, 0.0931189, 0.584609, 3.39331e-6, 2.09365e-6, 0.0279751, 3.72205e-7, 1.93193e-7, 3.3518e-7, 0.00982746, 7.05673e-8, 1.85854, 3.10245, 0.0411806, 0.18422, 0.15904, 0.125575, 0.999979, 0.999833, 0.999975, 0.438353, 0.0833079, 3.68965e-6, 2.1214e-6, 0.00559436, 7.17635e-6, 1.36769e-5, 5.05165e-7, 2.73098e-6, 23.7124, 1.09021, 0.871557, 0.976526, 0.99985, 0.0294977, 0.562049, 0.957012, 0.720498, 0.519091, 0.0719678, 0.000321327, 4.23917e-5, 1.25089e-6, 0.0126416, 9.52996e-6, 0.0158301, 0.0094828, 0.953811, 0.962829, 0.999991, 0.124892, 0.999798, 0.959889, 0.999965, 0.285964]
end
