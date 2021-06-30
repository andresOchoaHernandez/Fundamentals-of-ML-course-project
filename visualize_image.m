function image = visualize_image(data,dimensions)
image = uint8(reshape(data,[dimensions(1) dimensions(2) dimensions(3)]));
end