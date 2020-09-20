import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_device_features/logic/providers/provider-add_place.dart';
import 'package:provider/provider.dart';

class BodyAddPlace extends StatefulWidget {
  const BodyAddPlace({Key key}) : super(key: key);

  @override
  _BodyAddPlaceState createState() => _BodyAddPlaceState();
}

class _BodyAddPlaceState extends State<BodyAddPlace> {
  final _formKey = GlobalKey<FormState>();

  void callValidator() {
    _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _CustomTextFormField('title', callValidator),
            _ImageSelectorOrDisplayer(),
          ],
        ),
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget {
  final String label;
  final Function callValidator;
  const _CustomTextFormField(
    this.label,
    this.callValidator, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validator =
        Provider.of<ProviderAddPlace>(context, listen: false).validators(label);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        onEditingComplete: callValidator,
        decoration: InputDecoration(labelText: label),
        validator: validator,
      ),
    );
  }
}

class _ImageSelectorOrDisplayer extends StatelessWidget {
  const _ImageSelectorOrDisplayer({Key key}) : super(key: key);

  Future<void> _getPicture(
      ImageSource imageSource, ProviderAddPlace provider) async {
    print(
        'call:_openCamera: ${imageSource == ImageSource.camera ? 'camera' : 'gallery'}');

    final pickedFile = await ImagePicker().getImage(
      source: imageSource,
      maxWidth: 600,
      maxHeight: 500,
    );
    provider.injectImage(File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderAddPlace>(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget _buildListTile(bool condition) {
      if (condition)
        return ListTile(
          leading: CircleAvatar(
              child: const Icon(Icons.image),
              backgroundColor: theme.errorColor),
          title: Text('Add some pictures'),
          subtitle: Text(
            'At least one is required',
            style: TextStyle(color: Colors.black45),
          ),
        );
      else
        return ListTile(
          leading: CircleAvatar(
              child: const Icon(Icons.image),
              backgroundColor: theme.primaryColor),
          title: Text('${provider.images.length} pictures uploaded'),
          subtitle: Text(
            'Swipe down to delete,\ndouble tap to zoom in,\ntodo: swipe up to edit',
            style: TextStyle(color: Colors.black45),
          ),
        );
    }

    return Column(
      children: [
        _buildListTile(provider.thereAreNotImages),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.8,
            maxHeight: size.height * 0.3,
          ),
          child: provider.thereAreNotImages
              ? Row(
                  children: [
                    FlatButton.icon(
                      onPressed: () =>
                          _getPicture(ImageSource.camera, provider),
                      icon: Icon(Icons.add_a_photo),
                      label: Text('from camera'),
                    ),
                    FlatButton.icon(
                      onPressed: () =>
                          _getPicture(ImageSource.gallery, provider),
                      icon: Icon(Icons.add_photo_alternate),
                      label: Text('from gallery'),
                    ),
                  ],
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    if (index < provider.images.length)
                      return _ListViewItem(
                        image: provider.images[index],
                      );
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton.icon(
                          onPressed: () =>
                              _getPicture(ImageSource.camera, provider),
                          icon: Icon(Icons.add_a_photo),
                          label: Text('from camera'),
                        ),
                        FlatButton.icon(
                          onPressed: () =>
                              _getPicture(ImageSource.gallery, provider),
                          icon: Icon(Icons.add_photo_alternate),
                          label: Text('from gallery'),
                        ),
                      ],
                    );
                  },
                  itemCount: provider.images.length + 1,
                  scrollDirection: Axis.horizontal,
                ),
        ),
      ],
    );
  }
}

class _ListViewItem extends StatelessWidget {
  final File image;
  const _ListViewItem({Key key, this.image}) : super(key: key);

  Future<void> _openPicture(
      {BuildContext context,
      ProviderAddPlace provider,
      ThemeData theme}) async {
    await showDialog(
      context: context,
      child: AlertDialog(
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          OutlineButton.icon(
            onPressed: () => provider.removeImage(image.path),
            icon: Icon(
              Icons.delete_outline,
              color: theme.errorColor,
            ),
            label: Text('Delete', style: TextStyle(color: theme.errorColor)),
          ),
        ],
        content: ClipRRect(
          child: Image.file(image),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<ProviderAddPlace>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Dismissible(
        direction: DismissDirection.vertical,
        confirmDismiss: (direction) {
          if (direction == DismissDirection.up) {
            return Future.value(false);
          } else
            return Future.value(true);
        },
        onDismissed: (_) {
          provider.removeImage(image.path);
        },
        key: Key(image.path),
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  colors: [
                    theme.accentColor.withOpacity(0.1),
                    theme.accentColor.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.delete_outline,
                      color: theme.errorColor,
                      size: 32.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.edit,
                      color: theme.primaryColor,
                      size: 32.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        child: InkWell(
          onDoubleTap: () =>
              _openPicture(context: context, provider: provider, theme: theme),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.file(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
