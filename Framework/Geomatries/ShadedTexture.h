#pragma once
#include "TextureRect.h"


class ShadedBuffer : public ShaderBuffer
{
public:
	ShadedBuffer() : ShaderBuffer(&data, sizeof(data))
	{
		data.selection = 1;
	}

	int* GetSelectionPtr() { return &data.selection; }

	struct Data
	{
		int selection;
		Vector3 dummy;
	};

private:

	Data data;


};

class ShadedTexture : public TextureRect
{
public:
	ShadedTexture(Vector3 position, Vector3 size, float rotation, wstring path);
	~ShadedTexture();

	void Render();
	void GUI();

private:
	ShadedBuffer* sb = nullptr;


};

