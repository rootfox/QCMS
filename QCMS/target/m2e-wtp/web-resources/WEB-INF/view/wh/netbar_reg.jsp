<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%> 

<!DOCTYPE html>
<html>
	<head>
		<title><s:message code="sys.title" /></title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="renderer" content="webkit">
		<link rel="stylesheet" href="${basePath}/css/bootstrap.min.css">
		<link rel="stylesheet" href="${basePath}/css/font-awesome.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/dataTables/dataTables.bootstrap.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/dataTables/fixedColumns.bootstrap.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/bootstrap-editable/bootstrap-editable.css"/>
		<link rel="stylesheet" href="${basePath}/css/datetimepicker/bootstrap-datetimepicker.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/bootstrap-dialog/bootstrap-dialog.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/select2/select2.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/select2/select2-bootstrap.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/uniform/uniform.css"/>
		<link rel="stylesheet" href="${basePath}/css/animate.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/webuploader/webuploader.css" />
		<link rel="stylesheet" href="${basePath}/css/blueimp/css/blueimp-gallery.min.css" />
		<link rel="stylesheet" href="${basePath}/css/style.min.css"/>
		<style type="text/css">.modal-lg .modal-body{padding: 0 !important;min-height:400px;}.lightBoxGallery img {margin:5px;width:160px;}
		.tabs-container .tab-pane .panel-body{border:none;}</style>
	</head>

	<body class="gray-bg">
	<div class="spiner-example">
       <div class="sk-spinner sk-spinner-three-bounce">
            <div class="sk-bounce1"></div>
            <div class="sk-bounce2"></div>
            <div class="sk-bounce3"></div>
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                       	<a href="${basePath}/netbar/regList" class="btn btn-white btn-margin-right"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                       	<shiro:hasPermission name="netbar:add">
                        	<a id="addRow" href="javascript:void(0);" class="btn btn-white btn-margin-right"><i class="fa fa-plus"></i>&nbsp;添加</a>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="netbar:del">
                        	<a id="delAll" href="javascript:void(0);" class="btn btn-white btn-margin-right" style="display: none;"><i class="fa fa-remove"></i>&nbsp;批量删除</a>
                        </shiro:hasPermission>
                    </div>
                    <div class="ibox-content">
                        <table class="table table-striped table-bordered table-hover " id="editable">
                            <thead>
                                <tr>
                                	<th>操作</th>
                                	<th>网吧注册号</th>
									<th>网吧名称</th>
									<th>工商登记号</th>
									<th>网吧地址</th>
									<th>联系人姓名</th>
									<th>联系人手机号</th>
                                	<th>实际客户机总数</th>
                                	<th>服务端版本</th>
                                	<th>客户端版本</th>
									<th>服务器内网IP</th>
									<th>服务器MAC</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${basePath}/js/jquery.min.js?v=2.1.4"></script>
    <script src="${basePath}/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${basePath}/js/json3.min.js"></script>
    <script src="${basePath}/js/dataTables/jquery.dataTables.min.js"></script>
    <script src="${basePath}/js/dataTables/dataTables.bootstrap.min.js"></script>
    <script src="${basePath}/js/dataTables/dataTables.extends.js"></script>
    <script src="${basePath}/js/dataTables/dataTables.fixedColumns.min.js"></script>
    <script src="${basePath}/js/dataTables/dataTables.table.js"></script>
    <script src="${basePath}/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script src="${basePath}/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${basePath}/js/bootstrap-dialog/bootstrap-dialog.min.js"></script>
    <script src="${basePath}/js/select2/select2.full.min.js"></script>
    <script src="${basePath}/js/select2/zh-CN.js"></script>
    <script src="${basePath}/js/validate/jquery.validate.min.js"></script>
    <script src="${basePath}/js/validate/messages_zh.min.js"></script>
    <script src="${basePath}/js/handlebars.js"></script>
    <script src="${basePath}/js/uniform/jquery.uniform.js"></script>
    <script src="${basePath}/js/webuploader/webuploader.min.js"></script>
    <script src="${basePath}/js/blueimp/jquery.blueimp-gallery.min.js"></script>
    <script src="${basePath}/js/content.min.js?v=1.0.0"></script>
    <script src="${basePath}/js/common.js" charset="utf-8"></script>
    <!--定义HTML模板-->
	<script id="tpl" type="text/x-handlebars-template">
		<div class="tabs-container">
             <ul class="nav nav-tabs">
                 <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">详细信息</a></li>
             </ul>
             <div class="tab-content">
                 <div id="tab-1" class="tab-pane active">
                     <div class="panel-body">
						<form class="form-horizontal" id="dataForm">
                        <input type="hidden" id="id" name="id" value="{{this.id}}">
		    			<div class="row m-b">
			    	    	<div class="col-sm-2 text-nowrap l-h"><span class="red">*</span>网吧名称：</div>
					    	<div class="col-sm-5"><input type="text" id="net_bar_name" name="net_bar_name" value="{{this.net_bar_name}}" class="form-control" required></div>
					    </div>
						<div class="row m-b">
			    	    	<div class="col-sm-2 text-nowrap l-h"><span class="red">*</span>工商登记号：</div>
					    	<div class="col-sm-5"><input type="text" id="business_reg_no" name="business_reg_no" value="{{this.business_reg_no}}" class="form-control" required></div>
					    </div>
					    <div class="row m-b">	
			            	<div class="col-sm-2 text-nowrap l-h"><span class="red">*</span>网吧地址：</div>
					    	<div class="col-sm-10">
								<input type="hidden" id="address_name" name="address_name" value="{{this.address_name}}">
								<select id="city_code" name="city_code">
									<option selected="true" value="">==请选择城市==</option>
					    			<c:forEach var="_areas" items="${areasList}">
			                      		<option value="${_areas.areasid}">${_areas.areasname}</option>          		
			                		</c:forEach>
					    		</select>&nbsp;&nbsp;
								<select id="area_code" name="area_code">
									<option selected="true" value="">==请选择区县==</option>
								</select>
							</div>
						</div>
			            <div class="row m-b">	
			            	<div class="col-sm-2 text-nowrap l-h"><span class="red">*</span>联系人姓名：</div>
					    	<div class="col-sm-5"><input type="text" id="contact_name" name="contact_name" value="{{this.contact_name}}" class="form-control" required></div>
			            </div>
			            <div class="row m-b">	
			            	<div class="col-sm-2 text-nowrap l-h"><span class="red">*</span>联系人手机号：</div>
					    	<div class="col-sm-5"><input type="text" id="contact_tel" name="contact_tel" value="{{this.contact_tel}}" class="form-control" required></div>
			            </div>
						<div class="row m-b">	
			            	<div class="col-sm-2 text-nowrap l-h"><span class="red">*</span>实际客户机总数：</div>
					    	<div class="col-sm-5"><input type="text" id="client_total" name="client_total" value="{{this.client_total}}" class="form-control" required></div>
			            </div>
						<div class="row m-b">		
			            	<div class="col-sm-2 text-nowrap"><span class="red">*</span>网吧公网IP：</div>
					    	<div class="col-sm-5"><input type="text" id="outside_network" name="outside_network" value="{{this.outside_network}}" class="form-control" required></div>
						</div>
			            <div class="row m-b">		
			            	<div class="col-sm-2 text-nowrap"><span class="red">*</span>服务器内网IP：</div>
					    	<div class="col-sm-5"><input type="text" id="inside_network" name="inside_network" value="{{this.inside_network}}" class="form-control" required></div>
						</div>
			            <div class="row m-b">		
			            	<div class="col-sm-2 text-nowrap"><span class="red">*</span>服务器MAC：</div>
					    	<div class="col-sm-5"><input type="text" id="server_mac" name="server_mac" value="{{this.server_mac}}" class="form-control" required></div>
						</div>
                     </div>
                 </div>
             </div>
        </div>
	</script>
    <script>
    	$(function(){
    		initDtSearch();//表格搜索框回车查询
    		var columns = [{data:'id'},{data:'id'},{data:'net_bar_name'},{data:'business_reg_no'},
    			{data:'address_name'},{data:'contact_name'},{data:'contact_tel'},{data:'client_total'},
    			{data:'server_version'},{data:'client_version'},{data:'inside_network'},{data:'server_mac'}];
    		var columnDefs = new Array();
    		var isVisible = $('#addRow').length>0 || $('#delAll').length>0;//权限按钮
    		columnDefs.push({targets:0, className:'text-center', orderable:false, render:optRenderAuth, visible:isVisible});//操作列
    		//表格初始化
			oTable = $('#editable').dataTable({//dom:dtDom
				scrollY: $('body').height()-260,
				scrollX: true, 
				fixedColumns: {leftColumns: 3},
				columns: columns,
	            columnDefs: columnDefs,
	            autoWidth: false,
				order:[[3, 'desc']],
				processing: true, 
				serverSide: true,//pipeline pages 管道式分页加载数据，减少ajax请求
			    ajax: {url:'${basePath}/netbar/load', type:'POST'}, 
			    searchDelay: 300, 
			    deferRender: true//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
			});//返回JQuery对象，api()方法添加到jQuery对象,访问API.
			dbTable = oTable.api();//$('#editable').DataTable();//返回datatable的API实例,
		    dbTable.on('error.dt', function(e, settings, techNote, message){//出现异常时调用
		        console.log('An error has been reported by DataTables:', message);
		    });
	        //预编译模板
	        var template = Handlebars.compile($('#tpl').html());
	        var dataDialog = function(){
	        	var $this = $(this);
	        	var title = '网吧注册', dataJson = {};
	        	if($this.is('i.fa-edit')){
	        		title = '编辑注册信息';
					var tr = $this.parents('tr');
					dataJson = dbTable.row(tr).data();
	        	}
	        	var $div = $(template(dataJson));
	        	BootstrapDialog.show({type:'type-default', size:'size-wide', message:$div, title:title, closable:true,
		       		 buttons: [{
		                 icon:'fa fa-save', label:'确定',
		               	 action: function(){
		               		var cityName = $("#city_code").find("option:selected").text();
    	                    var countyName = $("#area_code").find("option:selected").text();
    	                    $("#address_name").val(cityName + " " + countyName);
    	                    
		               		$('#dataForm').submit();
		             	 }
		             }, {
		            	 icon:'fa fa-close', label: '取消',
		                 action: function(dialog){
		                	 dialog.close();
		                 }
	             	}],
            		onshown: function(dialog){
            			$('#dataForm', $div).validate({
            				submitHandler: function(form){//提交事件      
            					$.com.ajax({
            				       	url:'${basePath}/netbar/add', 
            				       	data:$(form).serialize(),
            				       	success: function(data){
            				       		if(data.flag){
            				       			dialog.close();
            				       			dbTable.ajax.reload(null, false);
            				       		}else{
            				           		BootstrapDialog.alert({type:'type-danger', message:data.msg});
            				           	} 
            			       		},
      	                            error:function(){
      	                                BootstrapDialog.alert("保存失败，请检查您填写的数据！");
      	                            }
            					});  
            			   	},
            			   	rules:{
                            	net_bar_name:{ required:true },
                                business_reg_no:{ required:true, number:true, maxlength:20 },
                                city_code:{ required:true },
                                area_code:{ required:true },
                                contact_name:{ required:true },
                                contact_tel:{ required:true, number:true, maxlength:11,minlength:11 },
                                client_total:{ required:true, number:true, min:0 },
                                outside_network:{ required:true },
                                inside_network:{ required:true },
                                server_mac:{ required:true } 
                            },
                            messages:{
                            	net_bar_name:{ required:"请输入网吧名称" },
                                business_reg_no:{ required:"请输入工商登记号", number:"只能输入数字", maxlength:"最大长度不能超过20"},
                                city_code:{ required:"请选择城市" },
                                area_code:{ required:"请选择区县" },
                                contact_name:{ required:"请输入联系人姓名" },
                                contact_tel:{ required:"请输入联系人手机号", number:"只能输入数字", maxlength:"请输入长度为11位的手机号", minlength:"请输入长度为11位的手机号"},
                                client_total:{ required:"请输入实际客户机总数", number:"只能输入数字", min:"不能小于0" },
                                outside_network:{ required:"请输入网吧公网IP" },
                                inside_network:{ required:"请输入服务器内网IP" },
                                server_mac:{ required:"请输入服务器MAC" }
                            }
            			});
            			$("#city_code").change(function(){
							$("#area_code").empty();
  	                        $.ajax({
  	                        	url:'${basePath}/netbar/getAreas', 
  	                            data:'areasid=' + $(this).val(),
  	                            success:function(data){
  	                            	var obj = data.obj;
	                                for (i = 0; i < obj.length; i++) {
	                                	$("#area_code").append("<option value='"+obj[i].areasid+"'>" + obj[i].areasname + "</option>");
	                                }
	                                if($this.is('i.fa-edit')){//编辑页面时，显示二级的默认选项
	                                	$("#area_code").find("option[value='"+dataJson.area_code+"']").attr("selected",true);
	                                }
  	                            },
  	                            error:function(){
  	                                BootstrapDialog.alert("没有找到对应的数据～");
  	                            }
  	                        });
  	                    });
            			if($this.is('i.fa-edit')){
            				$("#city_code").val(dataJson.city_code);//显示文件所在模块下拉框值
            				$("#city_code").trigger("change");//触发一级的change，获取二级的值
            				
            				$("#business_reg_no").attr("disabled", "disabled");
            				$("#city_code").attr("disabled","disabled");
            				$("#area_code").attr("disabled","disabled");
            			}
               		}
	        	});
	        }
	      	//添加新行
	        $('#addRow').click(dataDialog);
	        $('#editable tbody').on('click', 'i.fa-edit', dataDialog);
	        $('#editable tbody').on('click', 'i.fa-remove:not("i.i-remove")', function(){//删除
	    		var $this = $(this);
	    		var tr = $this.parents('tr');
				dataJson = dbTable.row(tr).data();
	    		BootstrapDialog.confirm({type:'type-default', message:'确认是否删除?', callback:function(result){
	                if(result) {
	                	var pk = tr.find('a[data-type]:first').attr('data-pk');
	                	$.com.ajax({
	    			       	url: '${basePath}/netbar/del',
	    		           	data:{pk:dataJson.id, name:'status', value:'0'},
	    			       	success: function(data){
	    			           	if(data.flag){
	    			           		dbTable.row(tr).remove().draw(false);
	    			           		BootstrapDialog.alert("删除成功！");
	    			           	}else{
	    			           		BootstrapDialog.alert({type:'type-danger', message:'删除失败，请刷新重试！'});
	    			           	}
	    		       		},
                          	error:function(){
                          		BootstrapDialog.alert({type:'type-danger', message:'删除失败，请刷新重试！'});
                            }
	    				});
	                }
	            }});
	    	});
	        $('.spiner-example').hide();//移除遮罩层
		});
	</script>
</body>
</html>
