// 表单的HTML代码
function htmlString1(title, parentId, parentName) {
    var htmlStr = "";
    htmlStr += '<div style="width:400px;height:300px" >';
    htmlStr += '<div style=" line-height:30px; text-indent:10px; margin-bottom:20px; background-color:#eee; position:relative;">' + title + '</div>';
    htmlStr += '<div style="display:block; padding-bottom:5px;" align="center"  >';
    htmlStr += '<div><table><tr><td><input type="hidden" id="tmp_id" width="50px"/><input type="text" id="tmp_name" width="50px"><button onclick="SetQueryOrgTreeParam(\'' + parentId + '\',\'' + parentName + '\');">确定</button></td></tr></table></div>';
    htmlStr += '<div id="QueryOrgTree" class="ztree"></div>';
    htmlStr += '</div>';
    htmlStr += '</div>';
    return htmlStr;
}

// 表单的HTML代码
function htmlString2(title, roleId) {
    var htmlStr = "";

    htmlStr += '<div style="width:400px;height:300px;position:relative;" >';
    htmlStr += '<div style=" line-height:30px; text-indent:10px; margin-bottom:20px; background-color:#eee; position:relative;">' + title + '</div>';
    htmlStr += '<div style="display:block; padding-bottom:5px;" align="center"  >';
    htmlStr += '<div id="QueryOrgTree" class="ztree"></div>';
    htmlStr += '</div>';
    htmlStr += '<div style="position:absolute;bottom:20px;right:100px"><button onclick="authorizeMenu(\'' + roleId + '\')">确定</button></div>';
    htmlStr += '</div>';
    htmlStr += '<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>\n<script type="text/javascript" src="/lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>\n' +
        '<script type="text/javascript" src="/lib/zTree/v3/js/jquery.ztree.excheck-3.5.js"></script>';

    htmlStr += '<script> function resultMsg2(data, isCloseFrame) {\n' +
        'if (data.success) {\n' +
        '            layer.msg(data.message,{icon: 1, time: 1000,offset: [$(window).height() - 380, $(window).width() - 700] }, function () {\n' +
        '                let queryType="0";\n' +
        '                    $(".refreshEle:first").load("authorization/getAuthorizedMenuListByRoleId/' + roleId + '?queryType=\'0\'");\n' +
        '\n' +
        '                if (isCloseFrame) {\n' +
        'layer.closeAll()' +
        '                }\n' +
        '            });\n' +
        '        } else {\n' +
        '            layer.msg(data.message, {icon: 2, time: 1000});\n' +
        '        }\n' +
        '    }function authorizeMenu(roleId){' +
        '\n' +
        '//获取复选框/单选框选中的节点：\n' +
        'var checkedNodes = zTreeObj.getCheckedNodes();\n' +
        'let menuIds=[];' +
        'for(let node of checkedNodes){' +
        'menuIds.push(node.id)}' +
        ' $.ajax({\n' +
        '            url: "authorization/authorizeMenu/",\n' +
        '            type: "post",\n' +
        '            data: {menuIds: menuIds, roleId:roleId},\n' +
        '            success: function (data) {\n' +
        '                resultMsg2(data, true);\n' +
        '            }\n' +
        '        })}</script>';

    return htmlStr;
}

/**
 * 以树的形式列出所有父级
 */
function getParent1(path, title, parentId, parentName) {
    // 1.新打开一个框
    layer.open({
        type: 1,
        title: false,
        closeBtn: 0, // 没有关闭按钮
        shadeClose: true,
        skin: 'yourclass',
        content: htmlString1(title, parentId, parentName)
    });

    // 2.在框中嵌一个树
    QueryOrgTreeObj1(path);

}

/**
 * 以树的形式列出所有父级
 */
function getParent2(path, title, roleId) {
    // 1.新打开一个框
    layer.open({
        type: 1,
        title: false,
        closeBtn: 0, // 没有关闭按钮
        shadeClose: true,
        skin: 'yourclass',
        content: htmlString2(title, roleId)
    });

    // 2.在框中嵌一个树
    QueryOrgTreeObj2(path);

}

// 初始化树插件
function QueryOrgTreeObj1(path) {

    var setting = {
        data: {
            simpleData: {
                enable: true  //使用简单 Array格式的数据
            }
        },
        async: {
            enable: true, //开启异步加载处理
            url: path,
            autoParam: ["id"],   // 传递的参数
            dataType: "json",//默认text
            type: "get"//请求的方式
        }
        , callback: {
            onClick: ClickQueryOrgTreeNodeFunc
        }
    };

    var zNodes = [];
    // 初始化的树
    var zTreeObj = $.fn.zTree.init($("#QueryOrgTree"), setting, zNodes);
}

// 初始化树插件
function QueryOrgTreeObj2(path) {

    var setting = {
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: {"Y": "ps", "N": "ps"}
        },
        data: {
            simpleData: {
                enable: true  //使用简单 Array格式的数据
            }
        },
        async: {
            enable: true, //开启异步加载处理
            url: path,
            autoParam: ["id"],   // 传递的参数
            dataType: "json",//默认text
            type: "get"//请求的方式
        }
        /*, callback: {
            onClick: ClickQueryOrgTreeNodeFunc
        }*/
    };

    var zNodes = [];
    /* console.log("$")
     console.log($)
     console.log("$.fn")
     console.log($.fn)
     console.log("$.fn.zTree")

     console.log($.fn.zTree)*/
    // 初始化的树
    zTreeObj = $.fn.zTree.init($("#QueryOrgTree"), setting, zNodes);
}

function ClickQueryOrgTreeNodeFunc(event, treeId, treeNode) {
    $("#tmp_name").val(treeNode.name);
    $("#tmp_id").val(treeNode.id);

}

function SetQueryOrgTreeParam(parentId, parentName) {
    $("#" + parentName).val($("#tmp_name").val());
    $("#" + parentId).val($("#tmp_id").val());
    let index = layer.index;
    layer.close(index);
}

function submitForm(form, url) {
    let paramArr = $(form[0]).serializeArray();
    let param = {};
    paramArr.forEach((p) => {
        param[p.name] = p.value;
    })

    if (url.indexOf("update") >= 0) {
        console.log("upldate")
        $.ajax({
            url: url,
            type: "put",
            data: param,
            success: function (data) {
                resultMsg(data, true);

            }
        })
    } else {
        $.post(url, param, function (data) {
            resultMsg(data, true);

        })
    }

}

function resultMsg(data, isCloseFrame) {

    if (data.success) {
        layer.msg(data.message, {icon: 1, time: 1000}, function () {
            if (isCloseFrame) {
                var index = parent.layer.getFrameIndex(window.name);
                parent.location.reload();
                parent.layer.close(index);
            } else {
                location.reload();
            }

        });
    } else {
        layer.msg(data.message, {icon: 2, time: 1000});
    }
}

