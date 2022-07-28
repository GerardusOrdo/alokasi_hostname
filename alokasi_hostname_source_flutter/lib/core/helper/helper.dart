enum EnumComparableType { number, string }

enum EnumHasuraFetchType { query, mutation, subscription }

enum EnumDataManipulation {
  select,
  insert,
  insertOne,
  update,
  updateByPK,
  delete,
  deleteByPK
}

enum EnumLogicalOperator { and, or }
enum EnumDataType { string, integer, float }

class GetRouteOf {
  static String homepageRoute = '/';
  static String loginRoute = '/login';
  static String ownerRouteInput = '/owner/input';
  static String dcSiteRoute = '/dc-site';
  static String dcRoomTypeRoute = '/room-type';
  static String dcRoomRoute = '/room';
  static String dcContainmentRoute = '/containment';
  static String dcRackRoute = '/rack';
  static String dcHwTypeRoute = '/hardware-type';
  static String dcMountedFormRoute = '/mounted-form';
  static String dcBrandRoute = '/brand';
  static String dcHwModelRoute = '/hardware-model';
  static String dcHwRoute = '/hardware';
  static String zoomCoba = '/zoom-coba';
  static String solitaire = '/solitaire';
  static String visualDc = '/visual-dc';
  static String visualDcRack = '/visual-dc/rack';
  static String visualDcHardware = '/visual-dc/rack/hardware';

  //==============================================

  static String serverRoute = '/server';
  static String ownerRoute = '/owner';
  static String emailScheduleRoute = '/email-schedule';
}

class TableName {
  static String ownerTableName = 'vm_alloc_owner';
  static String ownerViewName = 'vm_alloc_owner';

  static String serverTableName = 'vm_alloc_server';
  static String serverViewName = 'vm_alloc_vw_server';

  static String emailScheduleTableName = 'vm_alloc_email_schedule';
  static String emailScheduleViewName = 'vm_alloc_vw_email_schedule';

  //==============================================

  static String dcOwnerTableName = 'dc_ops_dc_owner';
  static String dcOwnerViewName = 'dc_ops_dc_owner';

  static String dcSiteTableName = 'dc_ops_dc_site';
  static String dcSiteViewName = 'dc_ops_vw_dc_site';

  static String dcRoomTypeTableName = 'dc_ops_dc_room_type';
  static String dcRoomTypeViewName = 'dc_ops_dc_room_type';

  static String dcRoomTableName = 'dc_ops_dc_room';
  static String dcRoomViewName = 'dc_ops_vw_dc_room';

  static String dcContainmentTableName = 'dc_ops_dc_containment';
  static String dcContainmentViewName = 'dc_ops_vw_dc_containment';

  static String dcRackTableName = 'dc_ops_dc_rack';
  static String dcRackViewName = 'dc_ops_vw_dc_rack';

  static String dcHwTypeTableName = 'dc_ops_dc_hw_type';
  static String dcHwTypeViewName = 'dc_ops_dc_hw_type';

  static String dcMountedFormTableName = 'dc_ops_dc_mounted_form';
  static String dcMountedFormViewName = 'dc_ops_dc_mounted_form';

  static String dcBrandTableName = 'dc_ops_dc_brand';
  static String dcBrandViewName = 'dc_ops_dc_brand';

  static String dcHwModelTableName = 'dc_ops_dc_hw_model';
  static String dcHwModelViewName = 'dc_ops_dc_hw_model';

  static String dcHardwareTableName = 'dc_ops_dc_hardware';
  static String dcHardwareViewName = 'dc_ops_vw_dc_hardware';

  static String dcUserTableName = 'dc_ops_dc_user';

  static String elcSourceTableName = 'dc_ops_elc_source';
  static String elcSourceViewName = 'dc_ops_elc_source';

  static String dcHwPortTableName = 'dc_ops_dc_hw_port';
  static String dcIpTableName = 'dc_ops_dc_ip';
  static String dcOsTableName = 'dc_ops_dc_os';
  static String dcOsVersionTableName = 'dc_ops_dc_os_version';

  static String dcUserRoleTableName = 'dc_ops_dc_user_role';
  static String elcMcbTableName = 'dc_ops_elc_mcb';
  static String elcPanelTableName = 'dc_ops_elc_panel';
  static String elcPanelMainTableName = 'dc_ops_elc_panel_main';
  static String elcPduTableName = 'dc_ops_elc_pdu';
  static String elcPowerOutletTableName = 'dc_ops_elc_power_outlet';
  static String elcUpsTableName = 'dc_ops_elc_ups';
}

class FieldName {
  static Map<String, dynamic> ownerField = {
    'id': 'Int',
    'owner': 'String',
    'email': 'String',
    'phone': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> ownerViewField = {
    'id': 'Int',
    'owner': 'String',
    'email': 'String',
    'phone': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> serverField = {
    'id': 'Int',
    'id_owner': 'Int',
    'server_name': 'String',
    'ip': 'String',
    'status': 'smallint',
    'notes': 'String',
    'power_on_date': 'timestamptz',
    'user_notif_date': 'timestamptz',
    'power_off_date': 'timestamptz',
    'delete_date': 'timestamptz',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> serverViewField = {
    'id': 'Int',
    'id_owner': 'Int',
    'owner': 'String',
    'server_name': 'String',
    'ip': 'String',
    'status': 'smallint',
    'notes': 'String',
    'power_on_date': 'timestamptz',
    'user_notif_date': 'timestamptz',
    'power_off_date': 'timestamptz',
    'delete_date': 'timestamptz',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> emailScheduleField = {
    'id': 'Int',
    'id_server': 'Int',
    'date': 'timestamptz',
    'state': 'smallint',
    'status': 'smallint',
    'notes': 'String',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> emailScheduleViewField = {
    'id': 'Int',
    'id_server': 'Int',
    'server_name': 'String',
    'ip': 'String',
    'owner': 'String',
    'email': 'String',
    'date': 'timestamptz',
    'state': 'smallint',
    'status': 'smallint',
    'notes': 'String',
    'created': 'timestamptz',
  };

  //==============================================

  static Map<String, dynamic> dcOwnerField = {
    'id': 'Int',
    'owner': 'String',
    'email': 'String',
    'phone': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcOwnerViewField = {
    'id': 'Int',
    'owner': 'String',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcSiteField = {
    'id': 'Int',
    'id_owner': 'Int',
    'dc_site_name': 'String',
    'address': 'String',
    'map': 'String',
    'width': 'bigint',
    'height': 'bigint',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcSiteViewField = {
    'id': 'Int',
    'id_owner': 'Int',
    'owner': 'String',
    'dc_site_name': 'String',
    'address': 'String',
    'map': 'String',
    'width': 'bigint',
    'height': 'bigint',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcRoomTypeField = {
    'id': 'Int',
    'room_type': 'String',
  };

  static Map<String, dynamic> dcRoomTypeViewField = {
    'id': 'Int',
    'room_type': 'String',
  };

  static Map<String, dynamic> dcRoomField = {
    'id': 'Int',
    'id_owner': 'Int',
    'id_dc_site': 'Int',
    'id_room_type': 'Int',
    'room_name': 'String',
    'id_parent_room': 'Int',
    'x': 'Int',
    'y': 'Int',
    'width': 'Int',
    'height': 'Int',
    'rack_capacity': 'Int',
    'is_reserved': 'Boolean',
    'map': 'String',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcRoomViewField = {
    'id': 'Int',
    'id_owner': 'Int',
    'owner': 'String',
    'id_dc_site': 'Int',
    'dc_site_name': 'String',
    'id_room_type': 'Int',
    'room_type': 'String',
    'room_name': 'String',
    'id_parent_room': 'Int',
    'x': 'Int',
    'y': 'Int',
    'width': 'Int',
    'height': 'Int',
    'rack_capacity': 'Int',
    'is_reserved': 'Boolean',
    'map': 'String',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcContainmentField = {
    'id': 'Int',
    'id_owner': 'Int',
    'id_dc_room': 'Int',
    'topview_facing': 'smallint',
    'containment_name': 'String',
    'x': 'Int',
    'y': 'Int',
    'width': 'Int',
    'height': 'Int',
    'is_reserved': 'Boolean',
    'row': 'smallint',
    'column': 'smallint',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcContainmentViewField = {
    'id': 'Int',
    'id_owner': 'Int',
    'owner': 'String',
    'id_dc_room': 'Int',
    'room_name': 'String',
    'topview_facing': 'smallint',
    'containment_name': 'String',
    'x': 'Int',
    'y': 'Int',
    'width': 'Int',
    'height': 'Int',
    'is_reserved': 'Boolean',
    'row': 'smallint',
    'column': 'smallint',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcRackField = {
    'id': 'Int',
    'id_owner': 'Int',
    'id_room': 'Int',
    'id_containment': 'Int',
    'topview_facing': 'smallint',
    'rack_name': 'String',
    'description': 'String',
    'x': 'Int',
    'y': 'Int',
    'max_u_height': 'smallint',
    'require_position': 'Boolean',
    'width': 'smallint',
    'height': 'smallint',
    'is_reserved': 'Boolean',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcRackViewField = {
    'id': 'Int',
    'id_owner': 'Int',
    'owner': 'String',
    'id_room': 'Int',
    'room_name': 'String',
    'id_containment': 'Int',
    'containment_name': 'String',
    'topview_facing': 'Int',
    'rack_name': 'String',
    'description': 'String',
    'x': 'Int',
    'y': 'Int',
    'max_u_height': 'smallint',
    'require_position': 'Boolean',
    'width': 'smallint',
    'height': 'smallint',
    'is_reserved': 'Boolean',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcHwTypeField = {
    'id': 'Int',
    'hw_type': 'String',
  };

  static Map<String, dynamic> dcHwTypeViewField = {
    'id': 'Int',
    'hw_type': 'String',
  };

  static Map<String, dynamic> dcMountedFormField = {
    'id': 'Int',
    'mounted_form': 'String',
  };

  static Map<String, dynamic> dcMountedFormViewField = {
    'id': 'Int',
    'mounted_form': 'String',
  };

  static Map<String, dynamic> dcBrandField = {
    'id': 'Int',
    'brand': 'String',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcBrandViewField = {
    'id': 'Int',
    'brand': 'String',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcHwModelField = {
    'id': 'Int',
    'hw_model': 'String',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcHwModelViewField = {
    'id': 'Int',
    'hw_model': 'String',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcHardwareField = {
    'id': 'Int',
    'id_owner': 'Int',
    'id_dc_rack': 'Int',
    'id_brand': 'Int',
    'id_hw_model': 'Int',
    'frontback_facing': 'smallint',
    'id_hw_type': 'Int',
    'id_mounted_form': 'Int',
    'hw_connect_type': 'smallint',
    'is_enclosure': 'Boolean',
    'enclosure_column': 'smallint',
    'enclosure_row': 'smallint',
    'is_blade': 'Boolean',
    'id_parent': 'Int',
    'x_in_enclosure': 'smallint',
    'y_in_enclosure': 'smallint',
    'hw_name': 'String',
    'sn': 'String',
    'u_height': 'smallint',
    'u_position': 'smallint',
    'x_position_in_rack': 'smallint',
    'y_position_in_rack': 'smallint',
    'cpu_core': 'smallint',
    'memory_gb': 'Int',
    'disk_gb': 'Int',
    'watt': 'numeric',
    'ampere': 'numeric',
    'width': 'smallint',
    'height': 'smallint',
    'is_reserved': 'Boolean',
    'require_position': 'Boolean',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> dcHardwareViewField = {
    'id': 'Int',
    'id_owner': 'Int',
    'owner': 'String',
    'id_dc_rack': 'Int',
    'rack_name': 'String',
    'id_brand': 'Int',
    'brand': 'String',
    'id_hw_model': 'Int',
    'hw_model': 'String',
    'frontback_facing': 'smallint',
    'id_hw_type': 'Int',
    'hw_type': 'String',
    'id_mounted_form': 'Int',
    'mounted_form': 'String',
    'hw_connect_type': 'smallint',
    'is_enclosure': 'Boolean',
    'enclosure_column': 'smallint',
    'enclosure_row': 'smallint',
    'is_blade': 'Boolean',
    'id_parent': 'Int',
    'x_in_enclosure': 'smallint',
    'y_in_enclosure': 'smallint',
    'hw_name': 'String',
    'sn': 'String',
    'u_height': 'smallint',
    'u_position': 'smallint',
    'x_position_in_rack': 'smallint',
    'y_position_in_rack': 'smallint',
    'cpu_core': 'smallint',
    'memory_gb': 'Int',
    'disk_gb': 'Int',
    'watt': 'numeric',
    'ampere': 'numeric',
    'width': 'smallint',
    'height': 'smallint',
    'is_reserved': 'Boolean',
    'require_position': 'Boolean',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> elcSourceField = {
    'id': 'Int',
    'name': 'String',
    'watt': 'numeric',
    'ampere': 'numeric',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };

  static Map<String, dynamic> elcSourceViewField = {
    'id': 'Int',
    'name': 'String',
    'watt': 'numeric',
    'ampere': 'numeric',
    'image': 'String',
    'notes': 'String',
    'deleted': 'Boolean',
    'created': 'timestamptz',
  };
}
