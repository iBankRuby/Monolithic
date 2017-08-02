class RulesController < ApplicationController
  before_action :set_rule, only: %i[edit update]

  attr_reader :rule

  def index
    @rules = Rule.all
  end

  def new
    @rule = Rule.new
  end

  def create
    @rule = Rule.new

    if rule.save
      redirect_to :account_rules
    end
  end

  def edit; end

  def update
    if rule.update(rule_params)
      redirect_to :edit_account_rule, notice: 'Rules have updated'
    end
  end

  private

  def set_rule
    @rule = Rule.find(params[:id])
  end

  def rule_params
    params.fetch(:rules).permit()
  end
end
