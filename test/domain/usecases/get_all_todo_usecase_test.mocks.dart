// Mocks generated by Mockito 5.3.0 from annotations
// in todo_app/test/domain/usecases/get_all_todo_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_app/domain/entity/todo.dart' as _i2;
import 'package:todo_app/domain/repositories/todo_repo.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTodo_0 extends _i1.SmartFake implements _i2.Todo {
  _FakeTodo_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TodoRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepo extends _i1.Mock implements _i3.TodoRepo {
  MockTodoRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Todo>> getAllTodo() =>
      (super.noSuchMethod(Invocation.method(#getAllTodo, []),
              returnValue: _i4.Future<List<_i2.Todo>>.value(<_i2.Todo>[]))
          as _i4.Future<List<_i2.Todo>>);
  @override
  _i4.Future<_i2.Todo> createTodo(_i2.Todo? data) =>
      (super.noSuchMethod(Invocation.method(#createTodo, [data]),
              returnValue: _i4.Future<_i2.Todo>.value(
                  _FakeTodo_0(this, Invocation.method(#createTodo, [data]))))
          as _i4.Future<_i2.Todo>);
  @override
  _i4.Future<void> deleteTodo(int? key) => (super.noSuchMethod(
      Invocation.method(#deleteTodo, [key]),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.Todo> editTodo(int? key, _i2.Todo? data) =>
      (super.noSuchMethod(Invocation.method(#editTodo, [key, data]),
              returnValue: _i4.Future<_i2.Todo>.value(
                  _FakeTodo_0(this, Invocation.method(#editTodo, [key, data]))))
          as _i4.Future<_i2.Todo>);
}
