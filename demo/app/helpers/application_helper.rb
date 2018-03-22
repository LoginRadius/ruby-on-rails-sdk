module ApplicationHelper
 def LoginRadiusConfig
    @Config = {
      :sitename => "<LOGINRADIUS_SITENAME>",
      :appkey => "<LOGINRADIUS_APPKEY>",
      :appsecret => "<LOGINRADIUS_APPSECRET>"
     }
    @loginradius = LoginRadius::RestRequest.new(@Config);
  end;
end;
