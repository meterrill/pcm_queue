class TicketsController < ApplicationController
  def index
    @incomplete_tickets = Ticket.all.where(complete: false).order('tickets.created_at ASC')
    @complete_tickets = Ticket.all.where(complete: true).order('tickets.created_at ASC')
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:notice] = "Ticket successfully added!"
      redirect_to tickets_path
    else
      render :new
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      flash[:notice] = "Ticket successfully updated!"
      redirect_to tickets_path
    else
      render :edit
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    flash[:notice] = "Ticket successfully deleted."
    redirect_to tickets_path
  end

private
  def ticket_params
    params.require(:ticket).permit(:description, :complete)
  end
end
