<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\Base\Model;
use Illuminate\Support\Facades\Storage;

class ImageUsage extends Model
{
    use HasFactory;

    protected $table = 'image_usages';

    protected $fillable = [
        'image_id',
        'usage',
        'usage_id',
    ];

    public static function fileUsageStore(string $model = '', int $id = -1, array $data = [])
    {
        if (!array_key_exists('image_selection', $data)) {
            return false;
        }
        return self::updateOrCreate(['usage' => $model, 'usage_id' => $id], ['image_id' => $data['image_selection']]);
    }

    public static function getImages(string $usage = '', int $usage_id = -1)
    {
        $imageUsage = self::where(['usage' => $usage, 'usage_id' => $usage_id])->get()->toarray();
        $images = [];

        if (!empty($imageUsage)) {
            foreach ($imageUsage as $row) {
                $image = ImageUpload::find($row['image_id']);
                $images[] = Storage::disk('media')->url($image->image);
            }
        }
        // if(sizeof($images) === 1){
        //     return array_values($images)[0];
        // }
        return $images;
    }
}
