class DiscountFacade
  def self.holidays
    json = DiscountService.next_three_holidays
    @holidays = json.map do |data|
      Holiday.new(data)
    end
  end
end 