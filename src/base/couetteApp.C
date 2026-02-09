#include "couetteApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
couetteApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

couetteApp::couetteApp(const InputParameters & parameters) : MooseApp(parameters)
{
  couetteApp::registerAll(_factory, _action_factory, _syntax);
}

couetteApp::~couetteApp() {}

void
couetteApp::registerAll(Factory & f, ActionFactory & af, Syntax & syntax)
{
  ModulesApp::registerAllObjects<couetteApp>(f, af, syntax);
  Registry::registerObjectsTo(f, {"couetteApp"});
  Registry::registerActionsTo(af, {"couetteApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
couetteApp::registerApps()
{
  registerApp(couetteApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
couetteApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  couetteApp::registerAll(f, af, s);
}
extern "C" void
couetteApp__registerApps()
{
  couetteApp::registerApps();
}
