require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GRSSearch do
  let(:res_afrinic) { GRSSearch.lookup('41.206.1.10') }
  let(:res_google) { GRSSearch.lookup('66.249.64.0') }
  let(:res_kabel) { GRSSearch.lookup('178.27.236.214') }
	let(:res_ipv6) { GRSSearch.lookup('2804:14c:8793:89b5:add7:e834:9d29:5f75') }

  it "is able to fetch data from the API endpoint" do
    expect(res_google.class).to eq GRSSearch::Response
    expect(res_google.source).to eq 'arin-grs'
    expect(res_google.ip_from).to eq '66.249.64.0'
    expect(res_google.ip_to).to eq '66.249.95.255'
    expect(res_google.ip_from.to_i).to eq 1123631104
    expect(res_google.ip_to.to_i).to eq 1123639295
    expect(res_google.org).to eq 'GOGL'
    expect(res_google.name).to eq 'GOOGLE'
    expect(res_google.description).not_to be
    expect(res_google.status.downcase).to eq 'allocation'
    expect(res_google.country).not_to be
    expect(res_google.cidr).to eq '66.249.64.0/24'

    expect(res_afrinic.class).to eq GRSSearch::Response
    expect(res_afrinic.source).to eq 'afrinic-grs'
    expect(res_afrinic.ip_from).to eq '41.206.1.0'
    expect(res_afrinic.ip_to).to eq '41.206.1.255'
    expect(res_afrinic.ip_from.to_i).to eq 701366528
    expect(res_afrinic.ip_to.to_i).to eq 701366783
    expect(res_afrinic.org).not_to be
    expect(res_afrinic.name).to eq 'MTNNG-0007-MTNCORP-LAGREGION-WIMAX'
    expect(res_afrinic.status).to eq 'ASSIGNED PA'
    expect(res_afrinic.country).to eq 'NG'
    expect(res_afrinic.cidr).to eq '41.206.0.0/19'

    expect(res_kabel.class).to eq GRSSearch::Response
    expect(res_kabel.source).to eq 'ripe-grs'
    expect(res_kabel.ip_from).to eq '178.26.0.0'
    expect(res_kabel.ip_to).to eq '178.27.255.255'
    expect(res_kabel.ip_from.to_i).to eq 2988048384
    expect(res_kabel.ip_to.to_i).to eq 2988179455
    expect(res_kabel.org).not_to be
    expect(res_kabel.name).to eq 'KABEL-DEUTSCHLAND-CUSTOMER-SERVICES-23'
    expect(res_kabel.status).to eq 'ASSIGNED PA'
    expect(res_kabel.country).to eq 'DE'
    expect(res_kabel.cidr).to eq '178.27.128.0/17'


    expect(res_ipv6.class).to eq GRSSearch::Response
    expect(res_ipv6.source).to eq 'lacnic-grs'
    expect(res_ipv6.ip_from.to_s).to eq "2804:14c::"
    expect(res_ipv6.ip_to.to_s).to eq "2804:14d:ffff:ffff:ffff:ffff:ffff:ffff"
    expect(res_ipv6.ip_from.to_i).to eq 53189915322580728962426485453122174976
    expect(res_ipv6.ip_to.to_i).to eq 53189915481037053990955160640210075647
    expect(res_ipv6.org).not_to be
    expect(res_ipv6.name).not_to be
    expect(res_ipv6.status).to eq 'ALLOCATED'
    expect(res_ipv6.country).to eq 'BR'
    expect(res_ipv6.cidr).to eq 'CLATO S.A.'
  end
end
