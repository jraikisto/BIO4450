
function countAR()
    f = "bedtools_out.bed"
    lines = open(f)

    reads = zeros(0)
    for line in eachline(lines)
        parts = split(line, "\t")
        if parts[3] != "transcript"
            continue
        end
        fields = split(parts[9], ";")
        fields[1] = " " * fields[1]

        name = ""
        for y in fields
            s = split(y, " ")
            if s[2] == "gene_name"
                name = s[3][2:end-1]
                break
            end
        end
        if name == "AR"
            push!(reads, parse(Int64, parts[end]))
        end
    end
    println("Overlapping happens in $(length(reads)) transcripts when observing AR")
    println()
    println("Read amounts:")
    for (id, i) in enumerate(reads)
        println("$(round(Int, i))")
    end
    println()
    println("Total number of overlapping reads is $(round(Int, sum(reads)))")
end
countAR()
