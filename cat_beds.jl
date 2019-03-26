#readdlm gives out error if column contains stuff like "asd 23; eewf 32;"
function read_bed(path::String)
    lines = readlines(path)
    width=length(split(lines[1], '\t'))
    #lines = open(path)


    out = Array{Any, 2}(undef, length(lines), width)
    for (id, line) in enumerate(lines)
        columns = split(line, '\t')
        out[id, :] .= map(columns) do y
            try
                return parse(Float64, y)
            catch
                return y
            end
        end
    end
    return out
end

only_counts(path) = map(readlines(path)) do y
    parse(Int, split(y, '\t')[end])
end

#=function only_counts(path)
    lines = readlines(path)
    #lines = open(path)


    return map(readlines(path)) do y
        parse(Int, split(y, '\t')[end])
    end
end
=#
