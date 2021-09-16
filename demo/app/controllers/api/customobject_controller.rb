module Api
  class CustomobjectController < ApplicationController
    def create_custom_object_by_access_token
      access_token = params[:auth]
      object_name = params[:"object_name"]
      payload = params[:customobject]
      response = CustomObjectApi.create_custom_object_by_token(access_token, object_name, payload)

      render :status => response.code, :json => response.body
    end

    def get_custom_object_by_access_token
      access_token = params[:auth]
      obj_name = params[:"object_name"]
      response = CustomObjectApi.get_custom_object_by_token(access_token, obj_name)

      render :status => response.code, :json => response.body
    end

    def update_custom_object_by_access_token
      access_token = params[:auth]
      object_record_id = params[:"object_id"]
      object_name = params[:"object_name"]
      payload = params[:customobject]
      response = CustomObjectApi.update_custom_object_by_token(access_token, object_name, object_record_id, payload, 'partialreplace')

      render :status => response.code, :json => response.body
    end

    def delete_custom_object_by_access_token
      access_token = params[:auth]
      object_name = params[:"object_name"]
      object_record_id = params[:"object_id"]
      response = CustomObjectApi.delete_custom_object_by_token(access_token, object_name, object_record_id)

      render :status => response.code, :json => response.body
    end
  end
end
