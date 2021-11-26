<?php

use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\PostController;
use App\Http\Controllers\Api\RegisterController;
use Illuminate\Support\Facades\Route;

Route::post('/register', [RegisterController::class, 'store']);


Route::apiResource('categories', CategoryController::class)->names('api.v1.categories');

Route::apiResource('posts', PostController::class)->names('api.v1.posts');
