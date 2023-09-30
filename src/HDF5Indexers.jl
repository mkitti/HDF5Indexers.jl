module HDF5Indexers
    import HDF5
    import Eyeball
    export HDF5Indexer, index

    struct HDF5Indexer{O <: Union{HDF5.File,HDF5.Group}, C <: NamedTuple} <: AbstractDict{String, Any}
        parent::O
        children::C
	    function HDF5Indexer(p)
			pairs = Pair{Symbol,Any}[
				Symbol(k) => index(getindex(p,k))
				for k in keys(p)
			]
			#a = NamedTuple(Symbol(k) => v for (k,v) in attrs(p))
            #push!(pairs, :attrs => a)
            c = NamedTuple(pairs)
	    	new{typeof(p),typeof(c)}(p,c)
		end
	end
	index(h5o::Union{HDF5.File,HDF5.Group}) =
        HDF5Indexer(h5o)
    index(x) = x
	Base.parent(h5idx::HDF5Indexer) = getfield(h5idx, :parent)
	function Base.getproperty(h5idx::HDF5Indexer, s::Symbol)
		@inline
        try
            return getfield(getfield(h5idx, :children), s)
        catch err
            return nothing
        end
    end
	Base.propertynames(h5idx::HDF5Indexer) =
        propertynames(getfield(h5idx, :children))
	Base.fieldnames(H5IDX::Type{HDF5Indexer{<: Any, C}}) where C =
		(@inline; fieldnames(C))
	Base.show(io::IO, m::MIME"text/plain", h5idx::HDF5Indexer) =
		show(io, m, getfield(h5idx, :parent))

    HDF5.attrs(h5idx::HDF5Indexer) = HDF5.attrs(parent(h5idx))

    Base.keys(h5idx::HDF5Indexer) = keys(HDF5.attrs(parent(h5idx)))
    Base.getindex(h5idx::HDF5Indexer, idx...) = getindex(HDF5.attrs(parent(h5idx)), idx...)
    Base.length(h5idx::HDF5Indexer) = length(HDF5.attrs(parent(h5idx)))
    Base.iterate(h5idx::HDF5Indexer) = iterate(HDF5.attrs(parent(h5idx)))
    Base.iterate(h5idx::HDF5Indexer, state) = iterate(HDF5.attrs(parent(h5idx)), state)

    function Eyeball.getoptions(h5idx::HDF5Indexer)
        attr_icon = HDF5._tree_icon(HDF5.Attribute)
        k = Iterators.flatten((attr_icon .* "  " .* keys(h5idx), propertynames(h5idx)))
        v = Iterators.flatten((values(h5idx), (getproperty(h5idx, pn) for pn in propertynames(h5idx))))
        return collect(zip(k, v))
    end
end
