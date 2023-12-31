Geocoder.configure(lookup: :test, ip_lookup: :test)

Geocoder::Lookup::Test.add_stub(
  'New York, NY', [
    {
      'coordinates' => [40.7143528, -74.0059731],
      'address' => 'New York, NY, USA',
      'state' => 'New York',
      'state_code' => 'NY',
      'country' => 'United States',
      'country_code' => 'US'
    }
  ]
)
