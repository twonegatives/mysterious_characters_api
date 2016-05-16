class CommentsController < ApplicationController
  check_authorization
 
  def index
    authorize! :index, Comment
    @comments = ViewAllComments.obtain(current_ability, params)
    render
  end

  def create
    authorize! :create, Comment
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.character_id = params[:character_id]
    if comment.save
      head :created
    else
      render json: {errors: comment.errors.full_messages}.to_json, status: 400
    end
  end

  def destroy
    comment = Comment.find(params[:id].to_i)
    authorize! :destroy, comment
    comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
