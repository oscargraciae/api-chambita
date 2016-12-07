class Api::V1::CreditCardsController < BaseController
  before_filter :auth, only: [:create, :index, :destroy, :my_cards]

  def create
    if @user.conektaid
      customer = Conekta::Customer.find(@user.conektaid)
      conektaResp = customer.create_card(token: params[:conektaTokenId])

      card = CreditCard.new
      card.last4 = conektaResp.last4
      card.brand = conektaResp.brand
      card.token = conektaResp.id
      card.user_id = @user.id

      if card.save
        render json: card, status: 201
      else
        render json: { errors: card.errors }, status: 200
      end

    else
      customer = Conekta::Customer.create(name: @user.first_name + ' ' + @user.last_name,
                                          email: @user.email,
                                          phone: '88888888',
                                          cards: [params[:conektaTokenId]])

      card = CreditCard.new
      card.last4 = customer.cards[0].last4
      card.brand = customer.cards[0].brand
      card.token = customer.cards[0].id
      card.user_id = @user.id

      if card.save
        @user.conektaid = customer.id
        @user.save

        render json: card, status: 201
      else

        render json: card.errors, status: 200
      end
    end
  end

  def index
    if @user.conektaid
      customer = Conekta::Customer.find(@user.conektaid)
      render json: customer, status: 200
    else

      render json: { errors: '', message: 'Usuario no registrado en Conekta' }, status: :ok
    end
  end

  def my_cards
    cards = CreditCard.where(user_id: @user.id)
    render json: cards, status: :ok
  end

  def destroy
    customer = Conekta::Customer.find(@user.conektaid)
    pos = 0

    customer.cards.each_with_index do |val, index|
      pos = index if val[1].id === credit_cards_parms[:id]
    end

    card = customer.cards[pos].delete

    if card.deleted
      credit_card = CreditCard.find_by(token: credit_cards_parms[:id])

      if credit_card.destroy
        head 204
      else
        render json: { errors: credit_card.error, message: 'Ha ocurruido un error y no se ha podido borrar la tarjeta, contacte al administrador' }, status: 422
      end

    else
      render json: { errors: card.error, message: 'Ha ocurruido un error y no se ha podido borrar la tarjeta, contacte al administrador' }, status: 422
    end
  end

  # Validamos los parametros de entrada
  def credit_cards_parms
    params.permit(:id)
  end
end
