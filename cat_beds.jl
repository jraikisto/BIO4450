#readdlm gives out error if column contains stuff like "asd 23; eewf 32;"
function read_bed(path::String)
    lines = readlines(path)
    width=length(split(lines[1], '\t'))

    out = Array{Any, 2}(undef, length(lines), width)
    for (id, line) in enumerate(lines)
        columns = split(line, '\t')
        out[id, :] .= map(columns) do y
            #TODO: try and catch is horribly slow. Solution with all(isdigit, a) should prolly be preferred, but then there must be chek for 2E19 notation
            try
                return parse(Float64, y)
            catch
                return y
            end
        end
    end
    return out
end

only_counts(path::String) = map(readlines(path)) do y
    parse(Int, split(y, '\t')[end])
end

function dont_parse(path::String)
    lines = readlines(path)
    width=length(split(lines[1], '\t'))

    out = Array{Any, 2}(undef, length(lines), width)
    for (id, line) in enumerate(lines)
        out[id, :] .= split(line, '\t')
    end
    return out
end

function write_bed(bed::Array;o="output.bed")
    t = open(o, "w")

    for r in 1:size(bed, 1)
        write(t, "$(bed[r, 1])")
        for i in 2:size(bed, 2)
            write(t, "\t$(bed[r, i])")
        end
        write(t, "\n")
    end
    close(t)
end
