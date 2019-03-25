#!/bin/env julia
using DelimitedFiles
r = readdlm(ARGS[1])
r = r[34:end, :]; l=length(r[:, 1])

k = length(split(r[1, 8], ';')[9:end-1])
infos=Array{Any}(undef, l, k)
for i in 1:l
    infos[i, :] .= map(split(r[i, 8], ';')[9:end-1]) do y
        split(y, '=')[end]
    end
end


goods = (infos[:, 2] .!= ".") .& (infos[:, 2] .!= "synonymous_SNV") .& (infos[:, 5] .== ".")
t = open("report.tsv", "w")
write(t, "CHROM\tPOS\tREF\tALT\tDesc\ttype\tdetail\tcosmic\t1000g2014\n")
writedlm(t, hcat(r[goods, collect([1, 2, 4, 5])], infos[goods, :]))
close(t)
