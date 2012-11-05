class JobSerializer < ActiveModel::Serializer
  attributes :status, :links, :number_one, :number_two

  def initialize(object, options={})
    @object, @options = object, options
  end

  def serializable_hash
    hash = attributes
    if attributes[:status] == "finished"
      hash = hash.merge(:answer => @object.answer)
    end
    hash 
  end
end
