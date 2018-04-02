module CrimsonHexagon
  module Monitor
    module Common
      def results(id, start_date, end_date, hide_excluded=false)
        response = get("monitor/results",
                       id: id,
                       start: start_date,
                       end: end_date,
                       hideExcluded: hide_excluded)
        response
      end

      def sources(id, start_date, end_date)
        response = get("monitor/sources",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def interestaffinities(id, start_date, end_date,
                             daily = false, document_source = nil)
        options = {}
        options.merge!(documentsource: document_source) if document_source
        options.merge!(id: id,
                       start: start_date,
                       end: end_date,
                       daily: daily)
        response = get("monitor/interestaffinities", options)
        response
      end

      def wordcloud(id, start_date, end_date,
                    filter = nil)
        options = {}
        options.merge!(filter: filter) if filter
        options.merge!(id: id,
                       start: start_date,
                       end: end_date)
        response = get("monitor/wordcloud", options, false, true)
        response
      end

      def volume_by_date(id, start_date, end_date,
                         aggregate_by_day = false, use_local_time = false)
        response = get("monitor/dayandtime",
                       id: id,
                       start: start_date,
                       end: end_date,
                       aggregatebyday: aggregate_by_day,
                       uselocaltime: use_local_time)
        response
      end

      def volume_by_age(id, start_date, end_date)
        response = get("monitor/demographics/age",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def volume_by_ethnicity(id, start_date, end_date)
        response = get("monitor/demographics/ethnicity",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def volume_by_gender(id, start_date, end_date)
        response = get("monitor/demographics/gender",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def volume_by_city(id, start_date, end_date, country = nil)
        options = {}
        options.merge!(country: country) if country
        options.merge!(id: id,
                       start: start_date,
                       end: end_date)

        response = get("monitor/geography/cities", options)
        response
      end

      def volume_by_country(id, start_date, end_date)
        response = get("monitor/geography/countries",
                       id: id,
                       start: start_date,
                       end: end_date)
        response
      end

      def volume_by_state(id, start_date, end_date, country)
        response = get("monitor/geography/states",
                       id: id,
                       start: start_date,
                       end: end_date,
                       country: country)
        response
      end

      def posts(id, start_date, end_date,
                filter = nil,
                extend_limit = false,
                full_contents = false,
                geo_tagged = false)
        options = {}
        options.merge!(filter: filter) if filter
        options.merge!(id: id,
                       start: start_date,
                       end: end_date,
                       extend_limit: false,
                       full_contents: false,
                       geo_tagged: false)

        response = get("monitor/posts", options)
        response
      end

      def training_posts(id, category = nil)
        options = {}
        options.merge!(category: category) if category
        options.merge!(id: id)

        response = get("monitor/trainingposts", options)
        response
      end
    end
  end
end
