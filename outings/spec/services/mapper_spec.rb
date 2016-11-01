require 'rails_helper'

RSpec.describe Location, type: :service do
    let!(:gregorys) {Location.create(name: "Gregory's Coffee")}
    let!(:chipotle) {Location.create(name:"Chipotle", address:"2 Broadway, New York, NY 10004")}
    let!(:gregory_mapper) {Mapper.new(gregorys)}
    let!(:chipotle_mapper) {Mapper.new(chipotle)}



    describe '#search_string' do
      it 'makes a google-friendly search string' do
        expect(chipotle_mapper.search_string).to eq('Chipotle+2+Broadway+New+York+NY+10004')
      end
    end

    describe '#map_string' do
      it 'makes an api request string' do
        expect(chipotle_mapper.map_string).to include('maps.googleapis.com/maps/api/staticmap?center=Chipotle+2+Broadway+New')
      end
    end

    describe '#run' do
      it 'returns the correct map string' do
        expect(chipotle_mapper.run).to include('https://www.google.com/maps/embed/v1/search?q=Chipotle+2+Broadway')
      end

      it 'defaults to flatiron when no address' do
        expect(gregory_mapper.run).to include('https://www.google.com/maps/embed/v1/search?q=Gregory')
      end
    end
end
