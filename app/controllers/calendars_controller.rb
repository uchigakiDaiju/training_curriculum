class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
  
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plan = plans.map do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

      days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day,
               :day_of_the_week => wdays[(@todays_date + x).wday],:plans => today_plans}

      @week_days.push(days)
    end

  end
end


# require 'date'

# a = Date.new(1993, 2, 24)
# b = Date.parse('1993-02-24')
# b += 10

# b - a            #=> 10
# b.year           #=> 1993
# b.strftime('%a') #=> "Sat" 
#これではダメだったか。

# yesterday = Date.today - 1