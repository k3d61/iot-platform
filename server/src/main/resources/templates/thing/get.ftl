<#include "../common/header.ftl">
<body>
<#include "../common/navbar.ftl"/>
<div class="container-fluid" id="container-main">
<#if user??>
    <#include "../common/sidenavbar.ftl"/>
</#if>
    <main role="main" class="col-sm-9 ml-sm-auto col-md-10 pt-3">
        <div class="row">
            <div class="col-md-12">
                <div class="float-right p-1" v-if="role=='ALL' || role=='WRITE'">
                    <button v-on:click="newDevice" class="btn btn-outline-primary">Add Device</button>
                    <button class="btn btn-outline-primary">Import Device</button>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        {{ thing.name }}
                    </div>
                    <div class="card-body">

                    </div>
                    <div class="card-footer">
                        <div class="float-right">
                            <button v-on:click="edit" class="btn btn-primary btn-sm">EDIT</button>
                            <button v-on:click="generate" class="btn btn-primary btn-sm">GENERATE CLIENT</button>
                        </div>
                        <button class="btn btn-danger btn-sm float-left text-white">DELETE THING</button>
                    </div>
                </div>
            </div>
        </div>
    </main>
<#include "../modals/crud_device.ftl"/>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<script src="/static/js/app.js"></script>
<script>
    var token = $.cookie("authorization");
    var userId = ${user.id};
    var thingId = ${thing.id};
    var app = new Vue({
        el: '#container-main',
        data: {
            device:{},
            saveLoader:false,
            role:"",
            unit: {},
            thing: {},
            devices: []
        },
        methods: {
            "load": function () {

                var that = this;
                $.ajax({
                    url: "/thing/get/" + thingId,
                    success: function (data) {
                        that.thing = data;
                        that.unit = that.thing.parentUnit;
                        $.ajax({
                            url: "/unit/rights/"+that.unit.id+"/"+userId,
                            success: function (data) {
                                that.role = data[0].role;
                            }
                        });
                    }
                });

            },
            "newDevice": function () {

            },
            "edit": function () {

            },
            "generate": function () {

            },
            "saveUnit": function () {
                this.saveLoader = true;
                var that = this;
                if (!this.createUnit.id) {
                    that.createUnit.parentUnitId = unitId;
                    $.ajax({
                        "url": "/unit/create",
                        "method": "POST",
                        "data": that.createUnit,
                        "success": function (data) {
                            that.saveLoader = false;
                            $("#create_unit").modal('hide');
                            that.load();
                        }
                    });
                } else {
                    $.ajax({
                        "url": "/unit/update/" + unitId,
                        "method": "POST",
                        "data": that.createUnit,
                        "success": function (data) {
                            that.saveLoader = false;
                            $("#create_unit").modal('hide');
                            that.load();
                        }

                    });
                }
            }
        },
        mounted: function () {
            this.load()

        }
    })
</script>
</body>
</html>
