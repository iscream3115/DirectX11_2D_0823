struct VertexInput
{
    float4 position : POSITION0;
    float2 uv : TEXCOORD0;
};

struct PixelInput
{
    float4 position : SV_POSITION0;
	float2 uv : TEXCOORD0;
};

cbuffer WorldBuffer : register(b0)
{
	matrix _world;
}

cbuffer VPBuffer : register(b1)
{
	matrix _view;
	matrix _proj;
}

cbuffer ShadedBuffer : register(b0)
{
	int selection;
}

PixelInput VS(VertexInput input)
{
	PixelInput output;
	
	output.position = mul(input.position, _world);
	output.position = mul(output.position, _view);
	output.position = mul(output.position, _proj);
	
	output.uv = input.uv;
	return output;
}

Texture2D _sourceTex : register(t0);
SamplerState _samp : register(s0);

float4 PS(PixelInput input) : SV_Target
{
	float4 color = _sourceTex.Sample(_samp, input.uv);
	float4 resultColor = color;
	
	//Å×µÎ¸®
	if (0.99f < input.uv.x || input.uv.x < 0.01f || 0.99f < input.uv.y || input.uv.y < 0.01f)
	{
			return float4(0,0,0,0);
	}
	
	if (0.499f < input.uv.x && input.uv.x < 0.51f)
	{
		return float4(0, 0, 0, 0);
	}
	
	if (0.499f < input.uv.y && input.uv.y < 0.51f)
	{
		return float4(0, 0, 0, 0);
	}
	
	if (input.uv.x < 0.5f && input.uv.y < 0.5f)
	{
		color = _sourceTex.Sample(_samp, float2(input.uv.x * 2.0f, input.uv.y * 2.0f));
		resultColor = color;
	}
	if (input.uv.x > 0.5f && input.uv.y < 0.5f)
	{
		color = _sourceTex.Sample(_samp, float2(input.uv.x * -1.0f, input.uv.y * -1.0f));
		resultColor = color;
	}
	
		//if (selection == 1)
		//	return resultColor;
		//else if (selection == 2)
		//{
		////AM
		//	float3 temp;
		//	temp = dot(color.rgb, float3(0.299f, 0.587f, 0.144f));
		//	resultColor = float4(temp, color.a);
		//}
		//else if (selection == 3)
		//{
		////sepia
		//	float3 gray = float3(0.393f, 0.789f, 0.189f);
		//	float3 temp = dot(color.rgb, gray);
		//	temp.r += 0.2f;
		//	temp.g += 0.1f;
		//	resultColor = float4(temp, color.a);

		//}
		//else if (selection == 4)
		//{
		////Negative
		//	float3 negative = 1 - abs(color.rgb);
		//	resultColor = float4(negative, color.a);
		//}
		//else if (selection == 5)
		//{
		////Posterize
		//	float3 value = float3(4.0f, 4.0f, 4.0f);
		//	float3 posterize = round(color.rgb * value) / value;
		//	resultColor = float4(posterize, color.a);
		//}
	
	
	
		return resultColor;
	
	}