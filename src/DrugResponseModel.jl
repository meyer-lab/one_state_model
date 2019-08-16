module DrugResponseModel

include("DDEmodel.jl")
include("ODEmodel.jl")
include("plot.jl")
include("Hill.jl")

export get_data, remove_peaks, ddesolve, optimization, plotIt, residHill, optimize_hill

end # module
