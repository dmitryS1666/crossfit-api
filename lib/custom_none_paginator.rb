class CustomNonePaginator < JSONAPI::Paginator
  def initialize; end

  def apply(relation, _order_options)
    relation
  end

  def calculate_page_count(record_count)
    record_count
  end
end

class JSONAPI::RequestParser
  def parse_pagination(page)
    if disable_pagination?
      @paginator = CustomNonePaginator.new
    else
      original_parse_pagination(page)
    end
  end

  def disable_pagination?
    # your logic here
    # request params are available through @params or @context variables
    # so you get your action, path or any context data
  end

  def original_parse_pagination(page)
    paginator_name = @resource_klass._paginator
    unless paginator_name == :none
      @paginator = JSONAPI::Paginator.paginator_for(paginator_name).new(page)
    end
  rescue JSONAPI::Exceptions::Error => e
    @errors.concat(e.errors)
  end
end
