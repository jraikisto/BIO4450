using DelimitedFiles
function countAR()
    f = "bedtools_out.bed"
    tsv = readdlm("abundance.tsv")
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

            #Finding corresponding area in Kallisto
            print(parts[1])
            print(" ")
            id = ""
            for y in fields
                s = split(y, " ")
                if s[2] == "transcript_id"
                    id = s[3][2:end-1]
                    break
                end
            end
            estimate = tsv[tsv[:, 1] .== id, 4]
            isempty(id) ? println() : println("$(id) $(estimate) $(parts[end])")

        end
    end

    #Printing AR stats
    println("Overlapping happens in $(length(reads)) transcripts when observing AR")
    println()
    println("Read amounts:")
    for i in reads
        println("$(round(Int, i))")
    end
    println()
    println("Total number of overlapping reads is $(round(Int, sum(reads)))")
end
countAR()
