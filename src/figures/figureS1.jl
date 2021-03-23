""" Figure S1 to show the data and model comparison in other 3 drugs. """

function figureS1()

    concs, popul1, g1s1, g2s1 = load(189, 1)
    _, popul2, g1s2, g2s2 = load(189, 2)
    _, popul3, g1s3, g2s3 = load(189, 3)

    # find G1 std and mean ***** data ******
    g1S = cat(g1s1, g1s2, g1s3, dims = 4)
    g2S = cat(g2s1, g2s2, g2s3, dims = 4)
    g1m = mean(g1S, dims = 4) # mean G1
    g2m = mean(g2S, dims = 4) # mean G2

    ps = [
        44.184,
        1.24076,
        0.0692788,
        0.0460918,
        0.3822,
        0.854034,
        0.605391,
        0.771326,
        0.0138293,
        0.00183699,
        0.000293753,
        0.0127534,
        0.00011816,
        0.0142541,
        60.6069,
        0.899573,
        1.99993,
        0.0748216,
        1.99326,
        0.468332,
        1.99864,
        1.22536,
        0.000141615,
        0.0318616,
        0.000216899,
        8.80158e-7,
        0.598489,
        0.00110572,
        6.68492,
        2.05974,
        1.99936,
        0.167588,
        0.507586,
        0.316074,
        0.248084,
        0.826596,
        1.6164e-5,
        3.10987e-6,
        3.55996e-5,
        7.73526e-6,
        0.0774056,
        8.26708e-5,
        3.34656,
        2.83739,
        0.0907361,
        0.108245,
        1.9758,
        1.96985,
        1.9993,
        0.210137,
        0.0690636,
        1.30442e-5,
        0.0767181,
        0.00991078,
        6.87891e-5,
        1.45086e-5,
        18.2253,
        1.1841,
        1.00505,
        0.0735852,
        1.97326,
        0.783828,
        0.45769,
        1.99355,
        0.0519941,
        0.000533671,
        0.00204743,
        9.52975e-5,
        5.23806e-5,
        0.0677505,
        0.339953,
        0.403341,
        0.802518,
        0.470576,
        1.298,
        0.423103,
    ];
    efcs = getODEparams(ps, concs)

    # ******* model simulations ********
    G1 = zeros(189, 7, 5)
    G2 = zeros(189, 7, 5)

    t = LinRange(0.0, 95.0, 189)
    for k = 1:5 # drug number
        for i = 1:7 # concentration number
            G1[:, i, k], G2[:, i, k], _ = predict(efcs[:, i, k], efcs[:, 1, k], t)
        end
    end

    G1ref = JLD.load("data/G1ref.jld")["data"]
    G2ref = JLD.load("data/G2ref.jld")["data"]

    p1 = DrugResponseModel.plot_fig1(concs[:, 2], G1[:, :, 2], g1m[:, 1:7, 2, 1], "Doxorubicin", "G1", "a")
    p2 = DrugResponseModel.plot_fig1(concs[:, 2], G2[:, :, 2], g2m[:, 1:7, 2, 1], "Doxorubicin", "G2", "b")
    p3 = DrugResponseModel.plot_fig1(concs[:, 4], G1[:, :, 4], g1m[:, 1:7, 4, 1], "Paclitaxel", "G1", "c")
    p4 = DrugResponseModel.plot_fig1(concs[:, 4], G2[:, :, 4], g2m[:, 1:7, 4, 1], "Paclitaxel", "G2", "d")
    p5 = DrugResponseModel.plot_fig1(concs[:, 5], G1[:, :, 5], g1m[:, 1:7, 5, 1], "Palbociclib", "G1", "e")
    p6 = DrugResponseModel.plot_fig1(concs[:, 5], G2[:, :, 5], g2m[:, 1:7, 5, 1], "Palbociclib", "G2", "f")

    p0 = plot(legend = false, grid = false, foreground_color_subplot = :white, top_margin = 1.5cm)
    p7 = DrugResponseModel.plot_fig1(concs[:, 1], G1ref[:, :, 1], g1m[:, 1:7, 1, 1], "Lapatinib", "G1", "h")
    p8 = DrugResponseModel.plot_fig1(concs[:, 1], G2ref[:, :, 1], g2m[:, 1:7, 1, 1], "Lapatinib", "G2", "i")
    p9 = DrugResponseModel.plot_fig1(concs[:, 3], G1ref[:, :, 3], g1m[:, 1:7, 3, 1], "Gemcitabine", "G1", "j")
    p10 = DrugResponseModel.plot_fig1(concs[:, 3], G2ref[:, :, 3], g2m[:, 1:7, 3, 1], "Gemcitabine", "G2", "k")

    p11 = DrugResponseModel.plot_pG1(efcs[1:6, :, 2], 2.25, "Doxorubicin", "progression rates", "l", 0.35)
    p12 = DrugResponseModel.plot_pG1(efcs[7:12, :, 2], 0.2, "Doxorubicin", "death rates", "m", 0.05)
    p13 = DrugResponseModel.plot_pG1(efcs[1:6, :, 4], 2.25, "Paclitaxel", "progression rates", "n", 0.35)
    p14 = DrugResponseModel.plot_pG1(efcs[7:12, :, 4], 0.2, "Paclitaxel", "death rates", "o", 0.05)
    p15 = DrugResponseModel.plot_pG1(efcs[1:6, :, 5], 2.25, "Palbociclib", "progression rates", "p", 0.35)
    p16 = DrugResponseModel.plot_pG1(efcs[7:12, :, 5], 0.2, "Palbociclib", "death rates", "q", 0.05)
    figureS1 = plot(p1, p2, p3, p4, p5, p6, p0, p0, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, size = (2400, 1050), layout = (3, 6))
    savefig(figureS1, "figureS1.svg")
end
