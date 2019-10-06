require 'dry/transaction'
class DynamicOperators
    BASE_PAGE_SIZE = 10
    def getPaginatedDataSet(queryset, page=1)
        qs = queryset.paginate(page, BASE_PAGE_SIZE)
        return {
            data: qs,
            meta_pagination: {
                current_page: qs.current_page,
                records_per_page: 10,
                prev_page: qs.prev_page,
                next_page: qs.next_page,
                total_records: qs.pagination_record_count,
                page_record_range: qs.current_page_record_range
            }
            
        }
    end

    def isInclude(key, allow_params)
        return allow_params.include? key
    end
end