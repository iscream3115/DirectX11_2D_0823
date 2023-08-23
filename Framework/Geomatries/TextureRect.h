#pragma once

class TextureRect
{
public:
    TextureRect(Vector3 position, Vector3 size, float rotation, wstring path);
    ~TextureRect();

    void Update();
    void Render();

    void SetShader(wstring shaderPath);

protected:
    vector<VertexTexture> vertices;
    VertexBuffer* vb = nullptr;

    vector<uint> indices;
    IndexBuffer* ib = nullptr;

    InputLayout* il = nullptr;

    VertexShader* vs = nullptr;
    PixelShader* ps = nullptr;

    Matrix world;
    Matrix S, R, T;

    WorldBuffer* wb = nullptr;

    Vector3 position;
    Vector3 size;
    float rotation;

    ID3D11ShaderResourceView* srv = nullptr;
};