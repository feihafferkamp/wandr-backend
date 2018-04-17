class ChatroomsController < ApplicationController

	def create
		chatroom = Chatroom.create(name: params[:name], password: params[:password])
		render json: prepare_chatroom(chatroom)
	end

	def index
		render json: Chatroom.all.map { |c| prepare_chatroom(c)}
	end

	def open
		chatroom = Chatroom.find(params[:chatroom_id])
		if chatroom
			render json: prepare_chatroom(chatroom, true)
		else
			render json: {error: "You dun goofed!"}
		end
	end

	def add_message
		chatroom = Chatroom.find(params[:chatroom_id])
		if chatroom && user
			message = Message.create(chatroom: chatroom, user: user_in_session, content: params[:content])
			ChatroomChannel.broadcast_to(chatroom, {
				type: 'ADD_MESSAGE',
				payload: prepare_message(message)
			})
			render json: prepare_message(message)
		else
			render json: {error: "You dun goofed!"}
		end
	end

	private

	def prepare_chatroom(chatroom, with_messages = false)
		chatroom_hash = { name: chatroom.name, id: chatroom.id }
		if with_messages
			chatroom_hash[:messages] = chatroom.messages.map {|m| prepare_message(m)}
		end
		chatroom_hash
	end

	def prepare_message(message)
    {id: message.id, content: message.content, username: message.user.username}
	end

end
