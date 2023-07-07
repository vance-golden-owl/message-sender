Timezone::Lookup.config(:test)

Timezone::Lookup.lookup.stub(40.7143528, -74.0059731, 'America/New_York')
