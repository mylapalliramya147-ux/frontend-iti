$(document).ready(function(){
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;
    loadTrades();
});

function esc(v){
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function loadTrades(){
    $.ajax({
        type:'get', url: baseUrl + 'api/trades',
        cache:false, timeout:600000,
        success: function(response){
            var sel = $("#tradeShort"); sel.empty();
            sel.append('<option value="">-SELECT-</option>');
            (response || []).forEach(function(t){
                var code = t.tradeShort || t.tradeCode || t.tradeName;
                var name = t.tradeName || t.tradeShort || code;
                if(code) sel.append('<option value="' + esc(code) + '">' + esc(name) + '</option>');
            });
        },
        error: function(){ $("#tradeShort").html('<option value="">-SELECT-</option>'); }
    });
}

function addMoreRow(){
    var row = '<tr class="item-row">'
        + '<td><input type="text" class="form-control itemName" placeholder="Item Name"/></td>'
        + '<td><input type="text" class="form-control itemCost" placeholder="Item Cost"/></td>'
        + '<td><input type="file" class="form-control itemPhoto" accept="image/*"/></td>'
        + '<td><button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">Remove</button></td>'
        + '</tr>';
    $("#itemsBody").append(row);
    return false;
}

function removeRow(btn){
    if($("#itemsBody tr.item-row").length > 1){
        $(btn).closest("tr").remove();
    }
    return false;
}

function readFileAsBase64(file){
    return new Promise(function(resolve){
        if(!file){ resolve(null); return; }
        var reader = new FileReader();
        reader.onload = function(e){
            var dataUrl = e.target.result || '';
            var comma = dataUrl.indexOf(',');
            resolve(comma >= 0 ? dataUrl.substring(comma + 1) : dataUrl);
        };
        reader.onerror = function(){ resolve(null); };
        reader.readAsDataURL(file);
    });
}

function submitLab(){
    $("#servermsg").html('');
    var industryName = $("#industryName").val().trim();
    var tradeShort = $("#tradeShort").val();
    var description = $("#description").val().trim();
    if(!industryName){ $("#servermsg").html("<span style='color:red;'>Industry Name is required.</span>"); return false; }
    if(!tradeShort){ $("#servermsg").html("<span style='color:red;'>Please select Trade for Lab.</span>"); return false; }

    var jobs = [];
    var valid = true;
    $("#itemsBody tr.item-row").each(function(){
        var name = $(this).find(".itemName").val().trim();
        var costRaw = $(this).find(".itemCost").val().trim();
        var file = $(this).find(".itemPhoto")[0].files[0];
        if(!name && !costRaw && !file) return;
        if(!name){ valid = false; return false; }
        var cost = costRaw === '' ? 0 : Number(costRaw);
        if(costRaw !== '' && isNaN(cost)){ valid = false; return false; }
        jobs.push({ name: name, cost: cost, file: file || null });
    });
    if(!valid){ $("#servermsg").html("<span style='color:red;'>Each equipment row needs Item Name and numeric Item Cost.</span>"); return false; }
    if(!jobs.length){ $("#servermsg").html("<span style='color:red;'>Add at least one equipment item.</span>"); return false; }

    $("#servermsg").html("<span style='color:blue;'>Saving...</span>");
    Promise.all(jobs.map(function(j){ return readFileAsBase64(j.file); })).then(function(photos){
        var items = jobs.map(function(j, i){
            var it = { itemName: j.name, itemCost: j.cost };
            if(photos[i]) it.itemPhoto = photos[i];
            return it;
        });
        var payload = { itiCode: insCode, industryName: industryName,
            tradeShort: tradeShort, description: description, items: items };
        $.ajax({
            type:'post', url: baseUrl + 'itilogin/lab-entry',
            contentType:'application/json', data: JSON.stringify(payload), timeout:600000,
            success: function(response){
                $("#servermsg").html("<span style='color:green;'>" + esc(response || 'Lab saved successfully!') + "</span>");
            },
            error: function(xhr){
                $("#servermsg").html("<span style='color:red;'>Error: " + esc(xhr.responseText || 'Error saving lab entry.') + "</span>");
            }
        });
    });
    return false;
}
