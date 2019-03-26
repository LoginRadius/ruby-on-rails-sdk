module Api
  class CustomobjectController < ApplicationController
    def create_custom_object_by_access_token
      access_token = params[:auth]
      obj_name = params[:"object_name"]
      data = params[:customobject]
      response = LoginRadiusCustomObjectClient.create_custom_object_by_access_token(access_token, obj_name, data)

      render :status => response.code, :json => response.body
    end

    def get_custom_object_by_access_token
      access_token = params[:auth]
      obj_name = params[:"object_name"]
      response = LoginRadiusCustomObjectClient.custom_object_by_access_token(access_token, obj_name)

      render :status => response.code, :json => response.body
    end

    def update_custom_object_by_access_token
      access_token = params[:auth]
      obj_id = params[:"object_id"]
      obj_name = params[:"object_name"]
      data = params[:customobject]
      response = LoginRadiusCustomObjectClient.custom_object_update_by_objectrecordid_and_access_token(access_token, obj_id, obj_name, "partialreplace", data)

      render :status => response.code, :json => response.body
    end

    def delete_custom_object_by_access_token
      access_token = params[:auth]
      obj_id = params[:"object_id"]
      obj_name = params[:"object_name"]
      response = LoginRadiusCustomObjectClient.custom_object_delete_by_objectrecordid_and_access_token(access_token, obj_id, obj_name)

      render :status => response.code, :json => response.body
    end
  end
end
