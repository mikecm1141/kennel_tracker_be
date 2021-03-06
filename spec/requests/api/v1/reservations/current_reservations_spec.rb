require 'rails_helper'

describe 'Runs API' do
  before(:each) do
    user = create(:user)
    @jwt = login_user(user)
  end
  context 'GET /api/v1/reservations/current' do
    it 'returns a list of active reservations' do
      owner1 = create(:owner)
      owner2 = create(:owner)
      reservation1, reservation2 = create_list(:reservation, 2, owner: owner1, checkin: 4.days.ago, checkout: 5.days.from_now)
      reservation3 = create(:reservation, owner: owner2, checkin: 10.days.ago, checkout: 7.days.ago)

      headers = {
        "Content-Type":"application/json",
        "Accept":"application/json",
        "Authorization":"Bearer #{@jwt}"
      }

      get '/api/v1/reservations/current', headers: headers
      current_resos = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(current_resos).to be_a(Hash)
      expect(current_resos).to have_key(:data)
      expect(current_resos[:data]).to be_a(Array)
      expect(current_resos[:data].length).to eq(2)
      expect(current_resos[:data][0]).to have_key(:id)
      expect(current_resos[:data][0][:id]).to eq(reservation1.id.to_s)
      expect(current_resos[:data][0]).to have_key(:type)
      expect(current_resos[:data][0][:type]).to eq("reservation")
      expect(current_resos[:data][0]).to have_key(:attributes)
      expect(current_resos[:data][0][:attributes]).to be_a(Hash)
      expect(current_resos[:data][0][:attributes]).to have_key(:runNumber)
      expect(current_resos[:data][0][:attributes]).to have_key(:checkin)
      expect(current_resos[:data][0][:attributes]).to have_key(:checkout)
      expect(current_resos[:data][0][:attributes]).to have_key(:grooming)
      expect(current_resos[:data][0][:attributes]).to have_key(:daycare)
      expect(current_resos[:data][0][:attributes]).to have_key(:boarding)
      expect(current_resos[:data][0][:attributes]).to have_key(:owner)
      expect(current_resos[:data][0][:attributes]).to have_key(:pet)
      expect(current_resos[:data][0][:attributes][:runNumber]).to eq(reservation1.run_number)
      expect(current_resos[:data][0][:attributes][:checkin].to_date).to eq(reservation1.checkin.to_date)
      expect(current_resos[:data][0][:attributes][:checkout].to_date).to eq(reservation1.checkout.to_date)
      expect(current_resos[:data][0][:attributes][:grooming]).to eq(reservation1.grooming)
      expect(current_resos[:data][0][:attributes][:daycare]).to eq(reservation1.daycare)
      expect(current_resos[:data][0][:attributes][:boarding]).to eq(reservation1.boarding)
      expect(current_resos[:data][0][:attributes][:owner]).to have_key(:data)
      expect(current_resos[:data][0][:attributes][:owner][:data]).to have_key(:id)
      expect(current_resos[:data][0][:attributes][:owner][:data]).to have_key(:type)
      expect(current_resos[:data][0][:attributes][:owner][:data]).to have_key(:attributes)
      expect(current_resos[:data][0][:attributes][:owner][:data][:id]).to eq(owner1.id.to_s)
      expect(current_resos[:data][0][:attributes][:owner][:data][:type]).to eq("owner")
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes]).to have_key(:firstName)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes]).to have_key(:lastName)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes]).to have_key(:address)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes]).to have_key(:homePhone)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes]).to have_key(:cellPhone)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes]).to have_key(:email)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes][:firstName]).to eq(owner1.first_name)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes][:lastName]).to eq(owner1.last_name)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes][:address]).to eq(owner1.address)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes][:homePhone]).to eq(owner1.home_phone)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes][:cellPhone]).to eq(owner1.cell_phone)
      expect(current_resos[:data][0][:attributes][:owner][:data][:attributes][:email]).to eq(owner1.email)
      expect(current_resos[:data][0][:attributes][:pet]).to have_key(:data)
      expect(current_resos[:data][0][:attributes][:pet][:data]).to have_key(:id)
      expect(current_resos[:data][0][:attributes][:pet][:data]).to have_key(:type)
      expect(current_resos[:data][0][:attributes][:pet][:data]).to have_key(:attributes)
      expect(current_resos[:data][0][:attributes][:pet][:data][:id]).to eq(reservation1.pet.id.to_s)
      expect(current_resos[:data][0][:attributes][:pet][:data][:type]).to eq("pet")
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:name)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:species)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:breed)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:color)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:dob)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:spayedNeutered)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:medications)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:feedingInstructions)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes]).to have_key(:shots)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:name]).to eq(reservation1.pet.name)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:species]).to eq(reservation1.pet.species)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:breed]).to eq(reservation1.pet.breed)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:color]).to eq(reservation1.pet.color)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:dob].to_date).to eq(reservation1.pet.dob.to_date)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:spayedNeutered]).to eq(reservation1.pet.spayed_neutered)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:medications]).to eq(reservation1.pet.medications)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:feedingInstructions]).to eq(reservation1.pet.feeding_instructions)
      expect(current_resos[:data][0][:attributes][:pet][:data][:attributes][:shots]).to eq(reservation1.pet.shots)
    end
  end
end
