""" Figure S1 to show the data and model comparison in other 3 drugs. """

function plot_pG1(efcs, ymax, Phasename, ylabel, subPlabel, plus)

    x = ["G11", "G12", "G21", "G22", "G23", "G24"]
    y1 = efcs[1:6, 1]
    y2 = efcs[1:6, 8]
    scatter(
        x,
        y1,
        color = "red",
        xlabel = "sub-phase",
        xrotation = 30,
        label = "Control",
        markerstrokewidth = 0,
        markersize = 8,
        ylabel = ylabel,
        titlefont = Plots.font("Helvetica", 12),
        legendfont = Plots.font("Helvetica", 9),
        guidefont = Plots.font("Helvetica", 12),
        xtickfont = Plots.font("Helvetica", 12),
        ytickfont = Plots.font("Helvetica", 12),
        bottom_margin = 1.5cm,
        fg_legend = :transparent,
        top_margin = 1.5cm,
        left_margin = 1.25cm,
        right_margin = 1.25cm,
        title = "$Phasename effects",
    )
    scatter!(
        x,
        y2,
        color = "cyan4",
        xlabel = "sub-phase",
        label = "Emax",
        markerstrokewidth = 0,
        markersize = 8,
        ylabel = ylabel,
        titlefont = Plots.font("Helvetica", 12),
        legendfont = Plots.font("Helvetica", 9),
        guidefont = Plots.font("Helvetica", 12),
        xtickfont = Plots.font("Helvetica", 12),
        ytickfont = Plots.font("Helvetica", 12),
        bottom_margin = 1.5cm,
        fg_legend = :transparent,
        top_margin = 1.5cm,
        left_margin = 1.25cm,
        right_margin = 1.25cm,
        title = "$Phasename effects",
    )
    annotate!(-0.5, (ymax + plus), text(subPlabel, :black, :left, Plots.font("Helvetica Bold", 15)))
    ylims!((-0.1, ymax))
end

function figureS3()

    concs, popul1, g1s1, g2s1 = load(189, 1)
    _, popul2, g1s2, g2s2 = load(189, 2)
    _, popul3, g1s3, g2s3 = load(189, 3)

    # find G1 std and mean ***** data ******
    g1S = cat(g1s1, g1s2, g1s3, dims = 4)
    g2S = cat(g2s1, g2s2, g2s3, dims = 4)
    g1m = mean(g1S, dims = 4) # mean G1
    g2m = mean(g2S, dims = 4) # mean G2
    ps = [48.1186, 1.17017, 0.0344367, 0.153542, 0.343799, 0.803251, 1.99644, 0.848162, 0.009062, 2.40783e-6, 2.12734e-5, 0.0538466, 5.83618e-5, 2.4157e-5, 15.5429, 1.43629, 0.367771, 0.0080823, 0.454744, 0.245463, 0.218754, 1.2806, 5.99234e-6, 0.0239985, 1.27509e-6, 4.87889e-6, 0.0179952, 0.146385, 4.99849, 1.90953, 0.510128, 0.220032, 0.221798, 1.60443, 0.240652, 0.950461, 2.01533e-7, 5.76098e-7, 8.91899e-7, 9.83827e-7, 0.0734884, 4.48427e-6, 3.62437, 2.74308, 0.0939696, 0.884336, 1.02885, 0.175659, 0.312402, 0.386282, 1.71926e-6, 0.373011, 5.02502e-6, 1.37135e-6, 0.127517, 2.9824e-6, 37.9028, 1.13736, 0.0930045, 0.591583, 0.456692, 1.10714, 1.31904, 1.3567, 4.92751e-7, 6.53767e-7, 0.0295615, 5.40729e-6, 5.87169e-6, 0.0568699, 0.212288, 1.28386, 0.310092, 1.44867, 1.99996, 0.471678]
    efcs = getODEparams(ps, concs)

    # ******* model simulations ********
    G1 = zeros(189, 8, 5)
    G2 = zeros(189, 8, 5)

    t = LinRange(0.0, 95.0, 189)
    for k = 1:5 # drug number
        for i = 1:8 # concentration number
            G1[:, i, k], G2[:, i, k], _ = predict(efcs[:, i, k], efcs[:, 1, k], t)
        end
    end

    G1ref = JLD.load("data/G1ref.jld")["G1ref"]
    G2ref = JLD.load("data/G2ref.jld")["G2ref"]

    G1short = zeros(189, 6, 5)
    G2short = zeros(189, 6, 5)
    G1refshort = zeros(189, 6, 5)
    G2refshort = zeros(189, 6, 5)
    g1mshort = zeros(189, 6, 5)
    g2mshort = zeros(189, 6, 5)
    G1short[:, 1, :] .= G1[:, 1, :]
    G2short[:, 1, :] .= G2[:, 1, :]
    G1refshort[:, 1, :] .= G1ref[:, 1, :]
    G2refshort[:, 1, :] .= G2ref[:, 1, :]
    g1mshort[:, 1, :] .= g1m[:, 1, :]
    g2mshort[:, 1, :] .= g2m[:, 1, :]
    G1short[:, 2:6, :] .= G1[:, 4:8, :]
    G2short[:, 2:6, :] .= G2[:, 4:8, :]
    G1refshort[:, 2:6, :] .= G1ref[:, 3:7, :]
    G2refshort[:, 2:6, :] .= G2ref[:, 3:7, :]
    g1mshort[:, 2:6, :] .= g1m[:, 3:7, :]
    g2mshort[:, 2:6, :] .= g2m[:, 3:7, :]
    p1 = DrugResponseModel.plot_fig1(concs[:, 2], G1short[:, :, 2], g1mshort[:, :, 2, 1], "Dynamical Model Fits - Doxorubicin", "G1", "A", :PuBu_6)
    p2 = DrugResponseModel.plot_fig1(concs[:, 2], G2short[:, :, 2], g2mshort[:, :, 2, 1], "Dynamical Model Fits - Doxorubicin", "S/G2", "B", :PuBu_6)
    p3 = DrugResponseModel.plot_fig1(concs[:, 4], G1short[:, :, 4], g1mshort[:, :, 4, 1], "Dynamical Model Fits - Paclitaxel", "G1", "C", :PuBu_6)
    p4 = DrugResponseModel.plot_fig1(concs[:, 4], G2short[:, :, 4], g2mshort[:, :, 4, 1], "Dynamical Model Fits - Paclitaxel", "S/G2", "D", :PuBu_6)
    p5 = DrugResponseModel.plot_fig1(concs[:, 5], G1short[:, :, 5], g1mshort[:, :, 5, 1], "Dynamical Model Fits - Palbociclib", "G1", "E", :PuBu_6)
    p6 = DrugResponseModel.plot_fig1(concs[:, 5], G2short[:, :, 5], g2mshort[:, :, 5, 1], "Dynamical Model Fits - Palbociclib", "S/G2", "F", :PuBu_6)

    p0 = plot(legend = false, grid = false, foreground_color_subplot = :white, top_margin = 1.5cm)
    p7 = DrugResponseModel.plot_fig1(concs[:, 1], G1refshort[:, :, 1], g1mshort[:, :, 1, 1], "Expon Model Fits - Lapatinib", "G1", "N", :YlOrBr_6)
    p8 = DrugResponseModel.plot_fig1(concs[:, 1], G2refshort[:, :, 1], g2mshort[:, :, 1, 1], "Expon Model Fits - Lapatinib", "S/G2", "O", :YlOrBr_6)
    p9 = DrugResponseModel.plot_fig1(concs[:, 3], G1refshort[:, :, 3], g1mshort[:, :, 3, 1], "Expon Model Fits - Gemcitabine", "G1", "P", :YlOrBr_6)
    p10 = DrugResponseModel.plot_fig1(concs[:, 3], G2refshort[:, :, 3], g2mshort[:, :, 3, 1], "Expon Model Fits - Gemcitabine", "S/G2", "Q", :YlOrBr_6)

    p11 = DrugResponseModel.plot_pG1(efcs[1:6, :, 1], 2.25, "Lapatinib", "progression rates [1/hr]", "G", 0.35)
    p12 = DrugResponseModel.plot_pG1(efcs[7:12, :, 1], 0.2, "Lapatinib", "death rates [1/hr]", "H", 0.06)
    p13 = DrugResponseModel.plot_pG1(efcs[1:6, :, 3], 2.25, "Gemcitabine", "progression rates [1/hr]", "I", 0.35)
    p14 = DrugResponseModel.plot_pG1(efcs[7:12, :, 3], 0.2, "Gemcitabine", "death rates [1/hr]", "J", 0.06)
    p15 = DrugResponseModel.plot_pG1(efcs[1:6, :, 5], 2.25, "Paclitaxel", "progression rates [1/hr]", "K", 0.35)
    p16 = DrugResponseModel.plot_pG1(efcs[7:12, :, 5], 0.2, "Paclitaxel", "death rates [1/hr]", "L", 0.06)
    figureS3 = plot(p1, p2, p3, p4, p5, p6, p11, p12, p13, p14, p15, p16, p0, p0, p7, p8, p9, p10, size = (2400, 1050), layout = (3, 6))
    savefig(figureS3, "figureS3.svg")
end

""" To plot the baseline Bliss overlayed with experimental data. """
function plot_figss()
    concs, popul1, g1s1, g2s1 = load(189, 1)
    expD = JLD.load("g.jld")["g"]
    C = output_Bliss_cellnum()

    D = (expD[1, 1:189, [1, 3, 4, 5, 6], [1, 2, 3, 4, 6]] .+ expD[2, 1:189, [1, 3, 4, 5, 6], [1, 2, 3, 4, 6]])
    p1 = DrugResponseModel.plot_fig1(concs[:, 1], C[:, :, 3, 4], D[:, :, 1], "palbo50 + lpts", "total", "A")
    p2 = DrugResponseModel.plot_fig1(concs[:, 3], C[:, :, 3, 9], D[:, :, 2], "palbo50 + gems", "total", "B")
    p3 = DrugResponseModel.plot_fig1(concs[:, 5], C[:, 3, :, 9], D[:, :, 3], "gem10 + palbos", "total", "C")
    p4 = DrugResponseModel.plot_fig1(concs[:, 1], C[:, :, 3, 2], D[:, :, 4], "gem10 + lpts", "total", "D")
    p5 = DrugResponseModel.plot_fig1(concs[:, 5], C[:, 4, :, 4], D[:, :, 5], "lpt100 + palbos", "total", "E")

    figureSS = plot(p1, p2, p3, p4, p5, size = (2000, 450), layout = (1, 5))
    savefig(figureSS, "figureSS.svg")
end
