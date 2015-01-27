require 'ipaddr'

class GRSSearch
  class Response
    attr_reader :source, :ip_from, :ip_to, :name, :description,
                :country, :status, :cidr, :org
           
    
    def initialize(json_data)
      json_data['objects']['object'].find_all { |data| data['type'] == 'inetnum' }.each do |i|
        @source ||= i['source']['id']
        
        # IP address range
        #
        if item = i['attributes']['attribute'].detect { |a| a['name'] == 'inetnum' }
          _ip_from, _ip_to = item['value'].split(/\s+-\s+/).map { |ip| ip.strip }
          @ip_from ||= IPAddr.new _ip_from
          @ip_to ||= IPAddr.new _ip_to
        end

        # net name
        #
        if item = i['attributes']['attribute'].detect { |a| a['name'] == 'netname' }
          @name ||= item['value']
        end

        # net description
        #
        if item = i['attributes']['attribute'].detect { |a| a['name'] == 'descr' }
          @description ||= item['value']
        end

        # country
        #
        if item = i['attributes']['attribute'].detect { |a| a['name'] == 'country' }
          @country ||= item['value']
        end

        # status
        #
        if item = i['attributes']['attribute'].detect { |a| a['name'] == 'status' }
          @status ||= item['value']
        end

        # organization
        #
        if item = i['attributes']['attribute'].detect { |a| a['name'] == 'org' }
          @org ||= item['value']
        end

      end

      json_data['objects']['object'].find_all { |data| data['type'] == 'route' }.each do |i|

        # network CIDR notation
        #
        if item = i['attributes']['attribute'].detect { |a| a['name'] == 'route' }
          @cidr = item['value']
        end
      end

      def inspect
        "GRSSearch::Response\##{self.object_id} - source:#{source} ip_from:#{ip_from} ip_to:#{ip_to} name:#{name} description:#{description} country:#{country} status:#{status} cidr:#{cidr} org:#{org}"
      end
    end
  end
end
