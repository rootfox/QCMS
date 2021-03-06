<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		<link rel="stylesheet" href="${basePath}/css/dataTables/dataTables.bootstrap.css"/>
		<link rel="stylesheet" href="${basePath}/css/bootstrap-editable/bootstrap-editable.css"/>
		<link rel="stylesheet" href="${basePath}/css/bootstrap-dialog/bootstrap-dialog.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/animate.min.css"/>
		<link rel="stylesheet" href="${basePath}/css/ztree/ztree.css"/>
		<link rel="stylesheet" href="${basePath}/css/style.min.css"/>
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
                       	<a href="${basePath}/node/list" class="btn btn-white btn-margin-right"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                        <a id="addRow" href="javascript:void(0);" class="btn btn-white"><i class="fa fa-plus"></i>&nbsp;添加</a>
                       	<input id="zNodes" type="hidden" value='${nodeTree}'>
                    </div>
                    <div class="ibox-content">
                    	<div class="row">
                    		<div class="col-sm-3">
                    			<ul id="nodeTree" class="ztree" style="padding-left: 20%;"></ul>
                    		</div>
                    		<div class="col-sm-9">
		                        <table class="table table-striped table-bordered table-hover " id="editable">
		                            <thead>
		                                <tr>
		                                    <th>编号</th>
											<th>名称</th>
											<th>级别</th>
											<th>父级编号</th>
											<th>类型</th>
											<th>权限标识符</th>
											<th>别名</th>
											<th>显示顺序</th>
											<th>链接</th>
											<th>图标样式</th>
											<th>微信菜单</th>
											<th>微信链接</th>
											<th>状态</th>
											<th>操作</th>
		                                </tr>
		                            </thead>
		                            <tbody>
		                            	<c:forEach var="node" items="${nodeSet}">
		                            		<tr>
												<td>${node.id}</td>
												<td><a href="#" id="name" data-type="text" data-pk="${node.id}">${node.name}</a></td>
												<td>${node.level}</td>
												<td>${node.parentId}</td>
												<td><a href="#" id="type" data-type="select" data-pk="${node.id}">${sysParam.SP001[node.type]}</a></td>
												<td><a href="#" id="permission" data-type="text" data-pk="${node.id}">${node.permission}</a></td>
												<td><a href="#" id="alias" data-type="text" data-pk="${node.id}">${node.alias}</a></td>
												<td><a href="#" id="sort" data-type="number" data-pk="${node.id}">${node.sort}</a></td>
												<td><a href="#" id="url" data-type="text" data-pk="${node.id}">${node.url}</a></td>
												<td><a href="#" id="icon" data-type="text" data-pk="${node.id}">${node.icon}</a></td>
												<td><a href="#" id="wxNode" data-type="select" data-pk="${node.id}">${node.wxNode?'是':'否'}</a></td>
												<td><a href="#" id="wxUrl" data-type="text" data-pk="${node.id}">${node.wxUrl}</a></td>
												<td><a href="#" id="status" data-type="select" data-pk="${node.id}">${node.status?'启用':'禁用'}</a></td>
												<td class="text-center"><i class="fa fa-edit fa-cursor"></i></td>
											</tr>
		                            	</c:forEach>
		                            </tbody>
		                        </table>
                    		</div>
                   		</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${basePath}/js/jquery.min.js?v=2.1.4"></script>
    <script src="${basePath}/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${basePath}/js/dataTables/jquery.dataTables.min.js"></script>
    <script src="${basePath}/js/dataTables/dataTables.bootstrap.min.js"></script>
    <script src="${basePath}/js/dataTables/dataTables.extends.js"></script>
    <script src="${basePath}/js/bootstrap-editable/bootstrap-editable.min.js"></script>
    <script src="${basePath}/js/dataTables/dataTables.editable.js"></script>
    <script src="${basePath}/js/bootstrap-dialog/bootstrap-dialog.min.js"></script>
    <script src="${basePath}/js/handlebars.js"></script>
    <script src="${basePath}/js/ztree/jquery.ztree.min.js"></script>
    <script src="${basePath}/js/content.min.js?v=1.0.0"></script>
    <script src="${basePath}/js/common.js" charset="utf-8"></script>
    <!--定义HTML模板-->
	<script id="tpl" type="text/x-handlebars-template">
		<a href="#" id="{{this.id}}" data-type="{{this.type}}"></a>
	</script>
    <script>
    	$(document).ready(function(){
    		var url = '${basePath}/node/edit';
    		var nodeType = toJsonArray('${sysParam.SP001}');
    		var onClick = function(event, treeId, treeNode, clickFlag) {
    			dbTable.columns(3).search('^'+treeNode.id+'$', true, false).draw();//正则表达式搜索
    		}
    		var setting={
   				view:{selectedMulti: false}, check:{enable: true},
   				data:{simpleData:{enable:true, idKey:'id', pidKey:'pId', rootPId:0}},
   				callback: {onClick: onClick}
   			};
    		var treeObj = $.fn.zTree.init($('#nodeTree'), setting, parseJSON($('#zNodes').val()));
    		$('#zNodes').remove();
    		var checkVal = function(objNode){
    			objNode.find('a[id="name"]').editable('option', 'validate', function(v) {
            		if(!$.trim(v)) return '节点名称不能为空！';
            	});
    			objNode.find('a[id="parentId"]').editable('option', 'validate', function(v) {
            		if(!$.trim(v)) return '父节点编号不能为空！';
            	});
    		}
    		//编辑插件初始化
    		$('a[data-type="text"],a[data-type="number"]').editable({disabled:true, url:url}).on('save', adjustColumn);
    		$('a[id="type"]').editable({disabled:true, source:nodeType, url:url});
        	$('a[id="wxNode"]').editable({disabled:true, source:whether, url:url});
        	$('a[id="status"]').editable({disabled:true, source:state, url:url});
        	checkVal($('#editable tbody'));
			//表格初始化
			oTable = $('#editable').dataTable({
				scrollX:true, order:[[0, 'asc']],
				columnDefs:[{targets:13, orderable:false}]
			});//返回JQuery对象，api()方法添加到jQuery对象,访问API.
			dbTable = oTable.api();//返回datatable的API实例,
	        //预编译模板
	        var template = Handlebars.compile($('#tpl').html());
	        //添加新行
	        $('#addRow').click(function(){
	        	var nodes = treeObj.getSelectedNodes();
	        	if(nodes.length==0){
	        		BootstrapDialog.alert({type:'type-default', message:'请从节点树中选中父级节点！'});
		        	return;
	        	}
	        	var node = nodes[0];
	        	var name = template({id:'name', type:'text'});
	        	var level = node.level+1;//template({id:'level', type:'number'});
	        	var parentId = node.id;//直接赋值父级节点编号
	        	var type = template({id:'type', type:'select'});
	        	var permission = template({id:'permission', type:'text'});
	        	var alias = template({id:'alias', type:'text'});
	        	var sort = template({id:'sort', type:'number'});
	        	var url = template({id:'url', type:'text'});
	        	var icon = template({id:'icon', type:'text'});
	        	var wxNode = template({id:'wxNode', type:'select'});
	        	var wxUrl = template({id:'wxUrl', type:'text'});
	        	var status = template({id:'status', type:'select'});
	        	var operate = '<td class="text-center"><i class="fa fa-save fa-cursor"></i>&nbsp;&nbsp;&nbsp;<i class="fa fa-remove fa-cursor"></i></td>';
	        	var nRow = oTable.fnAddData(['', name, level, parentId, type, permission, alias, sort, url, icon, wxNode, wxUrl, status, operate]);
	        	var tr = $(oTable.fnGetNodes(nRow));
	        	tr.find('a[data-type="text"],a[data-type="number"]').editable();
	        	tr.find('a[id="type"]').editable({value:1, source: nodeType});
	        	tr.find('a[id="wxNode"]').editable({value:0, source:whether});
	        	tr.find('a[id="status"]').editable({value:0, source:state});
	        	checkVal(tr);//验证数据
				afterAddRow(tr);
	        });//保存
	        $('#editable tbody').on('click', 'i.fa-save', function(){
				var $this = $(this);
				var tr = $this.parents('tr');
				var element = tr.find('a[data-type]');
				var obj = element.editable('getValue');
				if($.trim(obj.name)==''){
					BootstrapDialog.alert({type:'type-default', message:'节点名称不能为空！'});
					return;
				}
				var levelTd = tr.find('td:eq(2)');
				obj.level = levelTd.html();
				obj.parentId = levelTd.next().html();
				var data = JSON.parse(JSON.stringify(obj));
				$.com.ajax({
			       	url: '${basePath}/node/add', 
		           	data:data,
			       	success: function(data) {
			           	if(data.flag) {
			           		element.removeClass('editable-unsaved');
			           		element.editable('destroy');//销毁重新初始化
			           		var id = data.obj.id;
			           		tr.find('td:first').html(id);
			           		element.attr('data-pk', id);
			           		tr.find('a[data-type="text"],a[data-type="number"]').editable({
			           			pk:id, disabled:true, url:url
			    			}).on('save', adjustColumn);
			           		tr.find('a[id="type"]').editable({pk:id, disabled:true, source:nodeType, url:url});
				        	tr.find('a[id="wxNode"]').editable({pk:id, disabled:true, source:whether, url:url});
				        	tr.find('a[id="status"]').editable({pk:id, disabled:true, source:state, url:url});
				        	checkVal(tr);//验证数据
			               	$this.removeClass('fa-save').addClass('fa-edit');
			               	tr.find('i.fa-remove').remove();
			               	element.off('save');//解绑自动显示下一列编辑框事件
			               	dbTable.columns.adjust();//重新计算列宽
			           	}else{
			           		BootstrapDialog.alert({type:'type-danger', message:'保存失败，请刷新重试！'});
			           	}               
		       		}
				});
			}).on('click', 'i.fa-edit', function(){//编辑
				$(this).parents('tr').find('a[data-type]').editable('toggleDisabled');
			});
	        $('.spiner-example').remove();//移除遮罩层
		});
	</script>
</body>
</html>
