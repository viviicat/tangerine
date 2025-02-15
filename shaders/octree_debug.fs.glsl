--------------------------------------------------------------------------------

// Copyright 2022 Aeva Palecek
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


layout(std140, binding = 0)
uniform ViewInfoBlock
{
	mat4 WorldToView;
	mat4 ViewToWorld;
	mat4 ViewToClip;
	mat4 ClipToView;
	vec4 CameraOrigin;
	vec4 ScreenSize;
	vec4 ModelMin;
	vec4 ModelMax;
	float CurrentTime;
};


// NOTE: SSBO binding 0 is reserved for generated parameters.


layout(std140, binding = 2)
uniform InstanceDataBlock
{
	mat4 WorldToLocal;
	mat4 LocalToWorld;
	AABB Bounds;
};


layout(std140, binding = 3)
uniform OctreeDebugOptionsBlock
{
	uint OctreeID;
};


in vec3 LocalPosition;
in flat vec3 LocalMin;
in flat vec3 LocalMax;
in flat vec3 LocalCamera;


layout(location = 0) out vec3 OutPosition;
#if VISUALIZE_TRACING_ERROR
layout(location = 1) out vec4 OutNormal;
#else
layout(location = 1) out vec3 OutNormal;
#endif
layout(location = 2) out uint OutSubtreeID;
layout(location = 3) out vec3 OutMaterial;


void main()
{
	vec3 EyeRay = normalize(LocalPosition - LocalCamera);
	vec3 Position = EyeRay * BoxBrush(LocalCamera - Bounds.Center, Bounds.Extent) + LocalCamera;

	vec4 WorldPosition = LocalToWorld * vec4(Position, 1.0);
	WorldPosition /= WorldPosition.w;

	OutPosition = WorldPosition.xyz;
	OutNormal.xyz = vec3(0.0);
#if VISUALIZE_TRACING_ERROR
	OutNormal.a = 0.0;
#endif
	OutSubtreeID = OctreeID;
	OutMaterial = vec3(1.0);
}
