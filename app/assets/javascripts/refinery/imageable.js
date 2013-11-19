(function (refinery) {

    'use strict';

    /**
     * @constructor
     * @extends {refinery.admin.Imageable}
     * @param {Object=} options
     */
    refinery.Object.create({
        name: 'Imageable',

        module: 'admin',

        init_list: function () {
            var that = this,
                holder = that.holder,
                list = holder.find('#imageable-list'),
                images_dialog = refinery('admin.ImagesDialog'),
                tpl = list.data('new-imageable');

            function update_positions () {
                list.find('input.position').each(function (i) {
                    $(this).val(i);
                });
            }

            function image_list (index, image) {
                return tpl.replace(/{{thumbnail}}/g, image.thumbnail)
                    .replace(/{{image_id}}/g, image.id)
                    .replace(/{{image_alt}}/g, image.alt)
                    .replace(/{{image_caption}}/g, image.caption)
                    .replace(/{{i}}/g, index)
                    .replace(/{{position}}/g, index);
            }

            images_dialog.on('insert', function (img) {
                var i = list.find('li').length;

                list.html(list.html() + image_list(i, img));
            });

            images_dialog.on('load', function () {
                images_dialog.holder.find('li[aria-controls="external-image-area"]').hide();
            });

            that.on('destroy', function () {
                images_dialog.destroy();
            });

            holder.on('click', '.change', function () {
                var images_dialog = refinery('admin.ImagesDialog'),
                    li = $(this).closest('li'),
                    lis = list.find('li'),
                    i = lis.index(li);

                images_dialog.on('insert', function (img) {
                    li.find('img.preview').attr('src', img.thumbnail);
                    li.find('input.alt').val(img.alt);
                    li.find('input.caption').val(img.caption);
                    li.find('input.image-id').val(img.id);
                });

                images_dialog.on('load', function () {
                    images_dialog.holder.find('li[aria-controls="external-image-area"]').hide();
                });

                images_dialog.on('close', function () {
                    images_dialog.destroy();
                });

                that.on('destroy', function () {
                    images_dialog.destroy();
                })

                images_dialog.init().open();
            });

            holder.on('click', '.delete', function () {
                $(this).closest('li').remove();

                update_positions();
            });

            holder.on('click', '.add', function () {
                images_dialog.init().open();
            });

            holder.on('click', 'input[type="checkbox"]', function () {
                list.find('input[type="checkbox"]').not(this).each(function (){
                    $(this).prop('checked', false);
                });
            });

            list.sortable({
                stop: function () {
                    update_positions();
                }
            })
        },

        /**
         * Handle uploaded image
         *
         * @expose
         * @param {json_response} json_response
         * @return {undefined}
         */
        init: function (holder) {
            if (this.is('initialisable')) {
                this.is('initialising', true);
                this.holder = holder;

                this.init_list();

                this.is({'initialised': true, 'initialising': false});
                this.trigger('init');
            }
        }
    });

    refinery.admin.ui.imageable = function (holder, ui) {
        holder.find('#imageable').each(function () {
            ui.addObject( refinery('admin.Imageable').init($(this)) );
        });
    };

}(refinery));
