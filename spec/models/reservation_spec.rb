require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'Relationships' do
    it { should belong_to :pet }
    it { should belong_to :owner }
  end

  describe 'Validations' do
    it { should validate_presence_of(:checkin) }
    it { should validate_presence_of(:checkout) }
  end

  describe 'Class Methods' do
    context '.current' do
      it 'returns current reservations' do
        owner1 = create(:owner)
        owner2 = create(:owner)
        reservation1, reservation2 = create_list(:reservation, 2, owner: owner1, checkin: 4.days.ago, checkout: 5.days.from_now)
        reservation3 = create(:reservation, owner: owner2, checkin: 10.days.ago, checkout: 7.days.ago)

        result = Reservation.current

        expect(result.first).to be_a(Reservation)
        expect(result.length).to eq(2)
        expect(result).to eq([reservation1, reservation2])
      end
    end
  end
end

