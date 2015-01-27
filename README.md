grs-search
==========

A Ruby library to query the RIPE GRS API (http://rest.db.ripe.net/search). 
With grs-search you can lookup information regarding the network an IP address
belongs to.

Usage
-----

```ruby
require 'grs-search'

net = GRSSearch.lookup('66.249.64.121')

net.source
> "ARIN-GRS"

net.ip_from
> "66.249.64.0"

net.ip_to
> "66.249.95.255"

net.ip_from.to_i
> 1123631104

net.ip_to.to_i
> 1123639295

net.org
> 'GOGL'

net.net_name
> 'GOOGLE'

net.net_description
> 'DUMMY DESCRIPTION"

net.status
> 'allocation'

net.country
> 'FR'

net.net_cidr
> '66.249.64.0/24'

```

Contribute
----------

Feel free to fork this repository and send me pull requests if you add
functionality.

