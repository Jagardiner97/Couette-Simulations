//* This file is part of the MOOSE framework
//* https://mooseframework.inl.gov
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "couetteTestApp.h"
#include "couetteApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
couetteTestApp::validParams()
{
  InputParameters params = couetteApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

couetteTestApp::couetteTestApp(const InputParameters & parameters) : MooseApp(parameters)
{
  couetteTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

couetteTestApp::~couetteTestApp() {}

void
couetteTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  couetteApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"couetteTestApp"});
    Registry::registerActionsTo(af, {"couetteTestApp"});
  }
}

void
couetteTestApp::registerApps()
{
  registerApp(couetteApp);
  registerApp(couetteTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
couetteTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  couetteTestApp::registerAll(f, af, s);
}
extern "C" void
couetteTestApp__registerApps()
{
  couetteTestApp::registerApps();
}
