Location = {}
Location.Tabs = Behavior.create({
  onclick: function(e){
    e.stop();
    Location.ChooseTab(this.element);
  }
});

// factored out so that it can be called in an ajax response

Location.ChooseTab = function (element) {
  var pane = $(element.href.split('#')[1]);
  var panes = $('location').select('.pane');
  
  var tabs = $('location').select('.tab');
  tabs.each(function(tab) {tab.removeClassName('here');});
  
  element.addClassName('here');
  panes.each(function(pane) {Element.hide(pane);});
  Element.show($(pane));
}

Location.ChooseTabByName = function (tabname) {
  var element = $('tab_' + tabname);
  Location.ChooseTab(element);
}

Event.addBehavior({
  '#edit_page #location .tabs a': Location.Tabs
});
