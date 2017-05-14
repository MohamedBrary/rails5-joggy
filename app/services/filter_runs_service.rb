# app/services/filter_tickets_service.rb

# to be used in Runs index, and exposedt to Runs API call
class FilterRunsService

	def initialize(params)
    @from = params[:from].presence
    @to = params[:to].presence
    @runs = params[:runs]
  end

  def filter
  	# apply filter, if exists
    @runs.between @from, @to
  end

  def description
  	desc = {head: 'Listing Runs', filter: ''}
    desc[:head] = 'Filtering Runs' if @from.present? || @to.present?
    desc[:filter] = "from date '#{@from}' " if @from.present?
    desc[:filter] = "#{desc[:filter]}and " if @from.present? && @to.present?
    desc[:filter] = "#{desc[:filter]}to date '#{@to}'" if @to.present?
    desc
  end

end
