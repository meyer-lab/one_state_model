""" test - plot fitting  drugs SEPARATELY to see if it works well or not. """

function figure_AU565()
    setGadflyTheme()


    tensor, drugnames, concs, conds = DrugResponseModel.au565_all()
    bez = [2.29449, 1.89084, 0.909643, 0.120404, 7.04801e-6, 0.000230929, 0.398719, 0.601396, 0.516849, 3.99979, 5.03076e-5, 0.0254834, 0.0115742, 2.43724e-7, 6.94745e-7, 7.98949e-5, 2.77495e-6, 1.80014e-5, 3.99955, 0.386509, 3.99978, 0.0486005, 0.389932, 3.99993, 0.481651, 3.99941]
    tram = [130.474, 0.799689, 4.0, 4.0, 0.0161661, 0.164439, 0.209378, 0.132427, 1.47633, 4.0, 1.05135e-9, 1.00426e-9, 1.00062e-9, 1.00026e-9, 1.00123e-9, 1.00191e-9, 1.00749e-9, 1.0011e-9, 4.0, 3.9998, 0.0478146, 0.24385, 0.247926, 4.0, 1.46447, 3.9993]
    fiveFU = [580.389, 17.0851, 0.970604, 0.127075, 0.0594288, 0.0606395, 0.132572, 4.0, 0.627908, 4.0, 1.00136e-9, 1.00227e-9, 1.00146e-9, 1.0028e-9, 1.01774e-9, 1.06612e-9, 1.01923e-9, 1.01501e-9, 1.02116, 0.126543, 0.0626518, 0.984323, 0.221455, 4.0, 4.0, 4.0]
    azd = [1034.55, 2.91581, 0.381374, 0.25152, 6.10212e-9, 0.00018151, 0.347184, 0.463115, 3.99993, 3.99999, 1.29327e-8, 1.41262e-9, 0.0727894, 0.00203603, 1.07335e-7, 0.474572, 8.34571e-7, 9.41707e-8, 3.99997, 3.69688, 4.0, 0.0474874, 0.762073, 0.369361, 3.99806, 4.0]
    pano = [6.04596, 4.52115, 0.992575, 0.978064, 0.954076, 0.00832595, 0.0569454, 2.1484, 0.312449, 2.8517, 8.23383e-8, 1.52609e-8, 6.89081e-9, 0.0333258, 0.00980281, 1.49463e-8, 2.2833e-9, 2.26575e-8, 4.0, 4.0, 4.0, 0.0491176, 0.564873, 4.0, 0.469483, 4.0]
    mg132 = [33.206, 5.48368, 2.69039, 2.44802, 2.24241, 2.02186e-9, 0.528412, 4.0, 0.733123, 4.0, 1.45692e-7, 6.33791e-9, 4.60293e-8, 0.0241755, 0.349493, 2.20118e-7, 3.87289e-8, 1.78977e-8, 4.0, 4.0, 4.0, 0.0348436, 0.403923, 3.99898, 0.543448, 4.0]
    evero = [9988.45, 49.8646, 0.794329, 0.351642, 0.152327, 0.0117984, 0.702666, 0.4524, 0.13231, 0.507788, 0.00216659, 0.0153071, 0.0192719, 0.00164421, 0.0709424, 0.127882, 0.00127621, 0.303411, 0.98176, 0.670845, 0.370668, 0.0316005, 0.984334, 0.523077, 0.491864, 4.0]
    jq1 = [345.883, 1.25928, 1.28268, 2.71773e-9, 2.30293e-9, 0.0199905, 0.566364, 4.0, 0.621173, 4.0, 1.47553e-9, 0.0484056, 0.0304465, 1.08749e-9, 2.99571e-9, 6.02415e-8, 7.66601e-9, 1.28927e-8, 3.17288, 4.0, 4.0, 0.0364142, 0.462447, 3.99968, 0.5551, 4.0]
    borte = [142.587, 0.437201, 3.99994, 0.167528, 3.64452e-9, 8.02576e-8, 3.09757e-5, 1.2644e-7, 4.0, 4.0, 1.67723e-7, 0.00677967, 0.0400995, 0.0770584, 4.0, 0.376727, 1.68111e-6, 3.49249e-8, 3.99999, 0.16303, 0.0592622, 0.468842, 0.227596, 2.82645, 4.0, 4.0]
    mk = [1184.68, 2.36103, 0.845903, 0.251807, 0.0109914, 0.201168, 0.101926, 1.04642, 3.47738, 3.99985, 1.99795e-6, 2.81138e-6, 0.0285448, 0.922298, 1.4431e-6, 0.263966, 1.51932e-5, 6.02612e-6, 2.63038, 0.0733236, 0.0840215, 0.19002, 0.351416, 1.03876, 3.4744, 3.99994]
    cabo = [2953.15, 9.4644, 3.99978, 3.99998, 3.99994, 0.0267315, 0.166865, 1.35461, 2.2103, 0.309054, 6.18179e-7, 5.84534e-6, 2.01435e-7, 0.000768779, 0.0116867, 8.0461e-7, 3.35055e-7, 6.68166e-7, 3.99989, 3.99999, 4.0, 0.0474532, 0.36903, 4.0, 3.99997, 0.593924]
    params = [bez, tram, fiveFU, azd, pano, mg132, evero, jq1, borte, mk, cabo]
    pode = []
    for i=1:11
        push!(pode, getODEparams(params[i], concs[i]))
    end

    t = LinRange(0.0, 95, 189)
    Gs = zeros(189, 8, 2, 11)
    pp = []
    for i=1:11
        for j=1:8
            Gs[:, j, 1, i], Gs[:, j, 2, i], _ = DrugResponseModel.predict(pode[i][:, j, 1], pode[i][:, 1, 1], t)
        end
    push!(pp, DrugResponseModel.Eachdrug_sim(Gs[:, :, 1, i], tensor[1, :, :, i], conds[i], "G1", drugnames[i]))
    push!(pp, DrugResponseModel.Eachdrug_sim(Gs[:, :, 2, i], tensor[2, :, :, i], conds[i], "S/G2", drugnames[i]))

    end
    pl = plotGrid((6, 4), [pp...];)
    return draw(SVG("AU565_11drugs_separate_fits.svg", 20inch, 30inch), pl)
end


function figure_HCC()
    setGadflyTheme()

    tensor, drugnames, concs, conds = DrugResponseModel.hcc_all()
    bez = [1.20912, 4.72956, 8.56107, 0.133623, 2.94843, 0.302408, 4.69737, 0.397145, 0.71462, 0.437685, 0.00765007, 8.22314e-5, 0.00767598, 0.0342912, 0.0472248, 0.00426614, 0.0301918, 0.00619346, 8.88301, 1.56472, 8.30509, 0.217968, 4.74746, 0.319312, 9.90114, 0.294468]
    dox = [67.8417, 0.427192, 10.0, 10.0, 10.0, 0.0146513, 0.102349, 10.0, 1.00004e-6, 0.289089, 1.00011e-6, 1.00008e-6, 1.00001e-6, 1.0e-6, 1.0e-6, 1.00001e-6, 0.0744053, 1.0e-6, 10.0, 10.0, 10.0, 0.188744, 0.350372, 10.0, 10.0, 0.255558]
    gem = [3.12308, 1.16102, 10.0, 0.742043, 0.0295918, 0.093368, 0.245726, 10.0, 0.351444, 0.771963, 0.00363158, 0.101505, 1.0e-6, 1.0002e-6, 1.00001e-6, 1.00237e-6, 1.00001e-6, 1.0e-6, 10.0, 10.0, 0.18646, 10.0, 0.409743, 10.0, 0.304394, 0.760496]
    taxol = [9.2005, 1.77852, 1.63055, 0.54982, 0.247732, 0.0546419, 0.201451, 0.0683404, 6.39627, 0.278604, 1.96105e-6, 0.0781754, 1.65699e-6, 1.02777e-6, 1.04255e-6, 0.00464902, 1.02087e-6, 1.00664e-6, 9.99987, 9.99992, 1.92104, 0.233083, 0.644562, 0.610345, 9.99991, 0.285965]
    palbo = [12.7854, 3.3608, 0.894571, 0.652348, 0.0497805, 0.009887, 0.537593, 9.96164, 0.107693, 0.0723472, 1.72388e-6, 2.96368e-6, 1.31e-6, 0.0210291, 1.1064e-6, 3.07702e-6, 1.02804e-6, 0.00473437, 9.99245, 2.56584, 0.210321, 9.99978, 0.38706, 9.96147, 0.371839, 0.660508]
    Tram = [0.38958, 2.3611, 0.00152972, 6.39659, 0.317074, 0.298352, 0.776807, 0.260718, 0.133234, 0.41982, 0.0214788, 0.00159248, 0.000754532, 0.000259822, 1.87559e-5, 0.000100556, 0.000158653, 8.94501e-5, 3.4825, 6.93501, 0.380998, 0.484104, 1.24043, 0.422432, 1.4127, 0.365373]
    params = [taxol, palbo, Tram, bez, dox, gem]
    pode = []
    for i=1:6
        push!(pode, getODEparams(params[i], concs[i]))
    end

    t = LinRange(0.0, 95, 182)
    Gs = zeros(182, 8, 2, 6)
    pp = []
    for i=1:6
        for j=1:8
            Gs[:, j, 1, i], Gs[:, j, 2, i], _ = DrugResponseModel.predict(pode[i][:, j, 1], pode[i][:, 1, 1], t)
        end
    push!(pp, DrugResponseModel.Eachdrug_sim(Gs[:, :, 1, i], tensor[1, :, :, i], conds[i], "G1", drugnames[i]))
    push!(pp, DrugResponseModel.Eachdrug_sim(Gs[:, :, 2, i], tensor[2, :, :, i], conds[i], "S/G2", drugnames[i]))

    end
    pl = plotGrid((3, 4), [pp...];)
    return draw(SVG("HCC1143_6drugs_separate_fits.svg", 20inch, 16inch), pl)
end



function Eachdrug_sim_mt1(G_sim, G_data, condition, g1g2, drug_name)
    t = LinRange(0.0, 95, size(G_sim)[1])
    df = [DataFrame(x=t, y=G_sim[:, i], y2=G_data[:, i], conc=condition[i]) for i = 1:8]
    DF = vcat(df...)
    p = Gadfly.plot(DF, layer(x="x", y="y", Geom.line, color="conc"), 
                        layer(x="x", y="y2", Geom.line, color="conc", Theme(line_style=[:dash])),
                        Guide.xlabel("time [hr]"), Guide.ylabel("$g1g2 Cell #"), Coord.Cartesian(ymin=-0.05,ymax=20.0), Guide.title(drug_name))
    return p
end

function figure_21MT1()
    setGadflyTheme()

    tensor, names, concs, conds = DrugResponseModel.mt1_all()
    taxol_means1 = mean(tensor[1, :, :, [1, 3, 5, 9, 13]], dims=3)
    taxol_means2 = mean(tensor[2, :, :, [1, 3, 5, 9, 13]], dims=3)

    palbo_means1 = mean(tensor[1, :, :, [2, 4, 6, 10, 14]], dims=3)
    palbo_means2 = mean(tensor[2, :, :, [2, 4, 6, 10, 14]], dims=3)

    dox_means1 = mean(tensor[1, :, :, [8, 12]], dims=3)
    dox_means2 = mean(tensor[2, :, :, [8, 12]], dims=3)

    bez_means1 = mean(tensor[1, :, :, [7, 11]], dims=3)
    bez_means2 = mean(tensor[2, :, :, [7, 11]], dims=3)

    g1 = [taxol_means1, palbo_means1, dox_means1, bez_means1]
    g2 = [taxol_means2, palbo_means2, dox_means2, bez_means2]

    tax = [2.13313, 1.76866, 2.86983e-5, 9.90834, 0.0204786, 0.353558, 4.62399, 0.00056965, 0.645177, 9.68044, 0.000600321, 0.000248008, 1.7209e-5, 0.482705, 0.000334409, 0.0561086, 0.000102709, 0.000823313, 0.834943, 9.98515, 0.742378, 3.12026, 4.60891, 5.64477, 0.431239, 9.69486]
    palbo = [31.4019, 0.938298, 3.58708, 0.0726196, 6.14949, 1.21213e-6, 1.09333, 9.99417, 0.56802, 8.67633, 1.53954e-6, 1.00006e-6, 1.73669e-6, 0.00165267, 2.0494e-6, 3.05636e-6, 1.06993e-6, 5.07638e-6, 9.99966, 0.351513, 9.99836, 10.0, 1.04011, 9.99984, 0.618782, 9.99798]
    dox = [31.3338, 1.702, 0.000301515, 0.943418, 0.172958, 1.13342e-6, 0.000216733, 0.9267, 2.62969, 2.13338e-6, 5.82217e-6, 6.41533e-6, 0.0476792, 1.64461e-6, 1.0777, 1.08736e-6, 1.49161e-6, 1.03347e-6, 9.99677, 9.99966, 9.99832, 0.459419, 9.99991, 0.515813, 2.60123, 1.54234]
    bez = [14.1398, 2.10281, 0.149317, 0.917079, 0.196516, 0.0416924, 0.0795258, 0.388526, 4.42108, 0.411557, 1.70393e-6, 6.35515e-6, 1.19993e-6, 2.1036e-6, 1.01298e-6, 0.0101625, 2.18472e-5, 1.40495e-6, 9.99717, 2.25089, 0.558625, 9.99994, 9.98193, 0.57551, 9.47477, 0.924736]
    params = [tax, palbo, dox, bez]
    cds = [conds[1], conds[2], conds[8], conds[7]]
    css = [concs[1], concs[2], concs[8], concs[7]]
    drugnames = ["Taxol", "Palbociclib", "Doxorubicin", "BEZ235"]
    pode = []
    ii = 1
    for i=1:4
        push!(pode, getODEparams(params[i], css[i]))
        ii += 1
    end

    t = LinRange(0.0, 95, 193)
    Gs = zeros(193, 8, 2, 4)
    pp = []
    ii = 1
    for i=1:4
        for j=1:8
            Gs[:, j, 1, i], Gs[:, j, 2, i], _ = DrugResponseModel.predict(pode[i][:, j, 1], pode[i][:, 1, 1], t)
        end

    push!(pp, DrugResponseModel.Eachdrug_sim_mt1(Gs[:, :, 1, i], g1[i], cds[i], "G1", drugnames[i]))
    push!(pp, DrugResponseModel.Eachdrug_sim_mt1(Gs[:, :, 2, i], g2[i], cds[i], "S/G2", drugnames[i]))

    ii += 1
    end
    pl = plotGrid((4, 2), [pp...];)
    return draw(SVG("21MT1_4drugs_separate_fits.svg", 10inch, 20inch), pl)
end

function figure_MDAMB157()
    setGadflyTheme()

    tensor, names, concs, conds, _, _ = DrugResponseModel.mda_all()
    gem_means1 = mean(tensor[1, :, :, [1, 9, 15]], dims=3)
    gem_means2 = mean(tensor[2, :, :, [1, 9, 15]], dims=3)

    palbo_means1 = mean(tensor[1, :, :, [2, 5, 11, 17]], dims=3)
    palbo_means2 = mean(tensor[2, :, :, [2, 5, 11, 17]], dims=3)

    tram_means1 = mean(tensor[1, :, :, [3, 6, 12, 18]], dims=3)
    tram_means2 = mean(tensor[2, :, :, [3, 6, 12, 18]], dims=3)

    taxol_means1 = mean(tensor[1, :, :, [4, 10, 16]], dims=3)
    taxol_means2 = mean(tensor[2, :, :, [4, 10, 16]], dims=3)

    bez_means1 = mean(tensor[1, :, :, [7, 13]], dims=3)
    bez_means2 = mean(tensor[2, :, :, [7, 13]], dims=3)

    dox_means1 = mean(tensor[1, :, :, [8, 14]], dims=3)
    dox_means2 = mean(tensor[2, :, :, [8, 14]], dims=3)

    g1 = [gem_means1, palbo_means1, tram_means1, taxol_means1, bez_means1, dox_means1]
    g2 = [gem_means2, palbo_means2, tram_means2, taxol_means2, bez_means2, dox_means2]

    gem = [0.675774, 5.34262, 3.2038, 0.300506, 0.137523, 0.295067, 0.338499, 0.0909158, 0.542582, 7.54526, 1.96355e-5, 1.55292e-5, 1.95218e-5, 2.75029e-5, 2.8321e-6, 0.00331625, 0.0698959, 2.70958e-5, 9.76015, 8.86603, 9.79593, 0.0938808, 0.615315, 0.481513, 0.46567, 8.11252]
    palbo = [2904.0, 8.68973, 9.96123, 1.14607, 0.413321, 0.0627855, 0.132828, 1.69497, 0.191359, 0.899252, 0.000401075, 0.180248, 5.35693e-5, 1.29033e-6, 1.20163e-6, 1.2792e-5, 7.50934e-6, 1.58296e-5, 9.99463, 1.13057, 0.300003, 0.237256, 0.50217, 2.2563, 0.397316, 0.855188]
    tram = [229.704, 1.1198, 0.352808, 1.21148e-6, 7.13813e-6, 0.00663366, 1.4266e-6, 6.12125, 0.248056, 1.35795, 1.29449e-6, 0.00665833, 1.03433e-6, 1.04581e-6, 1.04441e-6, 1.28007e-5, 1.18686e-6, 5.39465e-6, 0.312943, 1.50229, 0.95395, 0.233189, 0.410435, 9.99829, 0.357342, 1.35201]
    taxol = [3.18958, 1.96436, 1.45588, 0.315983, 0.268681, 0.000457729, 0.000378863, 0.00791449, 0.354647, 9.89896, 0.217602, 9.95347e-6, 5.55943e-6, 4.63438e-5, 2.34652, 0.00254423, 1.13774e-6, 5.08121e-5, 1.45171, 0.276309, 0.192853, 1.0532, 9.9718, 0.543013, 0.312394, 9.92196]
    bez = [11.4012, 2.12124, 9.80473, 1.04785, 0.143397, 0.0404953, 0.113922, 0.165424, 0.636447, 0.428006, 0.00298439, 0.0016768, 1.11529e-5, 1.67309e-6, 1.0829e-6, 3.33035e-6, 0.115704, 0.00675543, 9.88892, 1.0398, 0.387576, 0.175695, 0.675849, 0.552237, 9.99949, 0.406304]
    dox = [9.77767, 1.57514, 1.00101e-6, 1.01096e-6, 1.51397, 0.162194, 0.0404188, 0.476739, 0.193782, 0.791658, 0.0253518, 0.00108866, 1.03332e-6, 1.02281e-6, 0.00825271, 1.01185e-6, 1.02936e-6, 1.01627e-6, 9.99998, 7.27028, 2.35881, 0.0961391, 0.486784, 10.0, 0.271848, 9.99998]
    params = [gem, palbo, tram, taxol, bez, dox]
    cds = [conds[1], conds[2], conds[3], conds[4], conds[7], conds[8]]
    css = [concs[1], concs[2], concs[3], concs[4], concs[7], concs[8]]
    drugnames = ["Gemcitabine", "Palbociclib", "Trametinib", "Taxol", "BEZ235", "Doxorubicin"]
    pode = []
    ii = 1
    for i=1:6
        push!(pode, getODEparams(params[i], css[i]))
        ii += 1
    end

    t = LinRange(0.0, 95, 193)
    Gs = zeros(193, 8, 2, 6)
    pp = []
    ii = 1
    for i=1:6
        for j=1:8
            Gs[:, j, 1, i], Gs[:, j, 2, i], _ = DrugResponseModel.predict(pode[i][:, j, 1], pode[i][:, 1, 1], t)
        end

    push!(pp, DrugResponseModel.Eachdrug_sim(Gs[:, :, 1, i], g1[i], cds[i], "G1", drugnames[i]))
    push!(pp, DrugResponseModel.Eachdrug_sim(Gs[:, :, 2, i], g2[i], cds[i], "S/G2", drugnames[i]))

    ii += 1
    end
    pl = plotGrid((6, 2), [pp...];)
    return draw(SVG("MDAMB157_6Drugs_separate_fits.svg", 10inch, 26inch), pl)

end