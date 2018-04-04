module LoginRadiusRaas
  module CustomObjectApi
    #
    # This API is used to retrieve all of the custom objects by account ID (UID).
    #
    # objectId = 'xxxxxxxxxxxx',
    # accountId = 'xxxxxxxxxxxx'
    #
    # return all custom field
    # {
    #     "Id": "53e31d61164ff214a0814327",
    #     "IsActive": true,
    #     "DateCreated": "2014-08-07T06:32:01.016Z",
    #     "DateModified": "2014-08-07T09:09:21.08Z",
    #     "IsDeleted": true,
    #     "Uid": "676d5049aba24314b8a5c5af1b80c0cb",
    #     "CustomObject": {
    #         "Id": "53e30b2c164ff114a044f3f4",
    #         "IsActive": true,
    #         "DateCreated": "2014-08-07T05: 14: 20.573Z",
    #         "DateModified": "2014-08-07T05: 14: 20.573Z",
    #         "IsDeleted": false,
    #         "Uid": "81ef41c461aa4a5eacba0a06f10c1481",
    #         "CustomObject": {
    #             "Industry": "chemical",
    #             "website": "http: //localhost23423423",
    #             "lastname": "",
    #             "RelationshipStatus": "married",
    #             "customfield1": {
    #                 "field1": "1",
    #                 "field2": "2",
    #                 "field5": "5",
    #                 "field6": "6"
    #             }
    #         }
    #     }
    # }
    #
    #
    def custom_object_get_by_accountid!(objectId, accountId)
      api_client("raas/v1/user/customObject", {:objectid => objectId,:accountid => accountId});
    end

    def custom_object_get_by_accountid(objectId, accountId)
      custom_object_get_by_accountid!(objectId, accountId)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to retrieve all of the custom objects by an object’s unique ID.
    #
    # objectId = 'xxxxxxxxxxxx';
    # recordId = 'xxxxxxxxxxxx';
    #
    # return all custom field
    # {
    #     "Id": "53e31d61164ff214a0814327",
    #     "IsActive": true,
    #     "DateCreated": "2014-08-07T06:32:01.016Z",
    #     "DateModified": "2014-08-07T09:09:21.08Z",
    #     "IsDeleted": true,
    #     "Uid": "676d5049aba24314b8a5c5af1b80c0cb",
    #     "CustomObject": {
    #         "Id": "53e30b2c164ff114a044f3f4",
    #         "IsActive": true,
    #         "DateCreated": "2014-08-07T05: 14: 20.573Z",
    #         "DateModified": "2014-08-07T05: 14: 20.573Z",
    #         "IsDeleted": false,
    #         "Uid": "81ef41c461aa4a5eacba0a06f10c1481",
    #         "CustomObject": {
    #             "Industry": "chemical",
    #             "website": "http: //localhost23423423",
    #             "lastname": "",
    #             "RelationshipStatus": "married",
    #             "customfield1": {
    #                 "field1": "1",
    #                 "field2": "2",
    #                 "field5": "5",
    #                 "field6": "6"
    #             }
    #         }
    #     }
    # }
    #
    #

    def custom_object_get_by_recordid!(objectId, recordId)
      api_client("raas/v1/user/customObject", {:objectid => objectId,:id => recordId});
    end

    def custom_object_get_by_recordid(objectId, recordId)
      custom_object_get_by_recordid!(objectId, recordId)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to retrieve all of the custom objects via a list of account IDs(UID) separated by , (Max 20).
    #
    # objectId = 'xxxxxxxxxxxx';
    # accountIds = 'xxxxxxxxxxxx,xxxxxxxxxxxx,xxxxxxxxxxxx';
    #
    # return all custom field
    # [{
    #     "Id": "53e31d61164ff214a0814327",
    #     "IsActive": true,
    #     "DateCreated": "2014-08-07T06:32:01.016Z",
    #     "DateModified": "2014-08-07T09:09:21.08Z",
    #     "IsDeleted": true,
    #     "Uid": "676d5049aba24314b8a5c5af1b80c0cb",
    #     "CustomObject": {
    #         "Id": "53e30b2c164ff114a044f3f4",
    #         "IsActive": true,
    #         "DateCreated": "2014-08-07T05: 14: 20.573Z",
    #         "DateModified": "2014-08-07T05: 14: 20.573Z",
    #         "IsDeleted": false,     #
    #         "Uid": "81ef41c461aa4a5eacba0a06f10c1481",
    #         "CustomObject": {
    #             "Industry": "chemical",
    #             "website": "http: //localhost23423423",
    #             "lastname": "",     #
    #             "RelationshipStatus": "married",
    #             "customfield1": {
    #                 "field1": "1",
    #                 "field2": "2",
    #                 "field5": "5",
    #                 "field6": "6"
    #             }
    #         }
    #     }
    # },
    # {
    #     "Id": "53e31d61164ff214a0814327",
    #     "IsActive": true,
    #     "DateCreated": "2014-08-07T06:32:01.016Z",
    #     "DateModified": "2014-08-07T09:09:21.08Z",
    #     "IsDeleted": true,
    #     "Uid": "676d5049aba24314b8a5c5af1b80c0cb",
    #     "CustomObject": {
    #         "Id": "53e30b2c164ff114a044f3f4",
    #         "IsActive": true,
    #         "DateCreated": "2014-08-07T05: 14: 20.573Z",
    #         "DateModified": "2014-08-07T05: 14: 20.573Z",
    #         "IsDeleted": false,
    #         "Uid": "81ef41c461aa4a5eacba0a06f10c1481",
    #         "CustomObject": {
    #             "Industry": "chemical",
    #             "website": "http: //localhost23423423",
    #             "lastname": "",
    #             "RelationshipStatus": "married",
    #             "customfield1": {
    #                 "field1": "1",
    #                 "field2": "2",
    #                 "field5": "5",
    #                 "field6": "6"
    #             }
    #         }
    #     }
    # }]
    #
    #
    def custom_object_get_by_accountids!(objectId, accountIds)
      api_client("raas/v1/user/customObject", {:objectid => objectId,:accountids => accountIds});
    end

    def custom_object_get_by_accountids(objectId, accountIds)
      custom_object_get_by_accountids!(objectId, accountIds)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to retrieve all of the custom objects by an object’s unique ID and filtered by a query
    #
    # objectId = 'xxxxxxxxxx';
    # query = "<Expression LogicalOperation='AND'>
    #              <Field Name='Provider' ComparisonOperator='Equal'>facebook</Field>
    #              <Expression LogicalOperation='OR'>
    #                  <Field Name='Gender' ComparisonOperator='Equal'>M</Field>
    #                  <Field Name='Gender' ComparisonOperator='Equal'>U</Field>
    #              </Expression>
    #          </Expression>";
    # ------------------ OR ------------------
    # query = "<Field Name='Gender' ComparisonOperator='Equal'>F</Field>";
    #
    # nextCursor=>[1]; (optional)
    # );
    #
    # return all custom field
    # {
    #     "Id": "53e31d61164ff214a0814327",
    #     "IsActive": true,
    #     "DateCreated": "2014-08-07T06:32:01.016Z",
    #     "DateModified": "2014-08-07T09:09:21.08Z",
    #     "IsDeleted": true,
    #     "Uid": "676d5049aba24314b8a5c5af1b80c0cb",
    #     "CustomObject": {
    #         "Id": "53e30b2c164ff114a044f3f4",
    #         "IsActive": true,
    #         "DateCreated": "2014-08-07T05: 14: 20.573Z",
    #         "DateModified": "2014-08-07T05: 14: 20.573Z",
    #         "IsDeleted": false,
    #         "Uid": "81ef41c461aa4a5eacba0a06f10c1481",
    #         "CustomObject": {
    #             "Industry": "chemical",
    #             "website": "http: //localhost23423423",
    #             "lastname": "",
    #             "RelationshipStatus": "married",
    #             "customfield1": {
    #                 "field1": "1",
    #                 "field2": "2",
    #                 "field5": "5",
    #                 "field6": "6"
    #             }
    #         }
    #     }
    # }
    #

    def custom_object_get_by_query!(objectId, query, nextCursor)
      api_client("raas/v1/user/customObject", {:objectid => objectId,:q => query,:cursor => nextCursor});
    end

    def custom_object_get_by_query(objectId, query, nextCursor=1)
      custom_object_get_by_query!(objectId, query, nextCursor)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to retrieve all records from a custom object.
    #
    # obejctId = 'xxxxxxxxxx';
    # nextCursor = [1]; (optional)
    #
    # return
    # {
    #     "Id": "53e31d61164ff214a0814327",
    #     "IsActive": true,
    #     "DateCreated": "2014-08-07T06:32:01.016Z",
    #     "DateModified": "2014-08-07T09:09:21.08Z",
    #     "IsDeleted": true,
    #     "Uid": "676d5049aba24314b8a5c5af1b80c0cb",
    #     "CustomObject": {
    #         "Id": "53e30b2c164ff114a044f3f4",
    #         "IsActive": true,
    #         "DateCreated": "2014-08-07T05: 14: 20.573Z",
    #         "DateModified": "2014-08-07T05: 14: 20.573Z",
    #         "IsDeleted": false,
    #         "Uid": "81ef41c461aa4a5eacba0a06f10c1481",
    #         "CustomObject": {
    #             "Industry": "chemical",
    #             "website": "http: //localhost23423423",
    #             "lastname": "",
    #             "RelationshipStatus": "married",
    #             "customfield1": {
    #                 "field1": "1",
    #                 "field2": "2",
    #                 "field5": "5",
    #                 "field6": "6"
    #             }
    #         }
    #     }
    # }
    #

    def custom_object_get_all_objects!(objectId, nextCursor)
      api_client("raas/v1/user/customObject", {:objectid => objectId,:cursor => nextCursor});
    end

    def custom_object_get_all_objects(objectId, nextCursor=1)
      custom_object_get_all_objects!(objectId, nextCursor)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to retrieve stats associated with a custom object
    #
    # objectId = 'xxxxxxxxxx';
    #
    # return
    # {
    #     "TotalUsedMemory": 0.01,
    #     "RemainingMemory": 9.99,
    #     "TotalRecords": 7
    # }
    #
    #

    def custom_object_get_stats!(objectId)
      api_client("raas/v1/user/customObject/stats", {:objectid => objectId});
    end

    def custom_object_get_all_objects(objectId)
      custom_object_get_all_objects!(objectId)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to save custom objects, by providing ID of object, to a specified account if the object is not exist it will create a new object.
    #
    # objectId = 'xxxxxxxxxx';
    # accountId = 'xxxxxxxxxx';
    # param = {
    #  firstname => 'first name',
    #  lastname => 'last name',
    #  gender => 'm',
    #  birthdate => 'MM-DD-YYYY',
    #  ....................
    #  ....................
    # }
    #
    # return { “isPosted” : true }
    #
    def custom_object_upsert!(objectId, accountId, param)
      api_client("raas/v1/user/customObject/upsert", {:objectid => objectId, :accountid => accountId}, param, 'json');
    end

    def custom_object_upsert(objectId, accountId, param = {})
      custom_object_upsert!(objectId, accountId, param)
    rescue LoginRadiusRaas::Exception => e
      false
      end

    #
    # This API is used to block Custom Object.
    #
    # objectId = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    # accountId = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    # action = true/false(boolean)
    #
    # return { “isPosted” : true }
    #
    def custom_object_set_status!(objectId, accountId, action)
      api_client("raas/v1/user/customObject/status", {:objectid => objectId, :accountid => accountId}, {:isblock => action});
    end

    def custom_object_set_status(objectId, accountId, action=true)
      custom_object_set_status!(objectId, accountId, action)
    rescue LoginRadiusRaas::Exception => e
      false
      end
  end
end
